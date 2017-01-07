# This file contains implementations of the commands accepted on the CLI.

. "$CHOCPKG_ROOT/chocpkg/functions.sh"
. "$CHOCPKG_ROOT/buildenv.sh"

# basic_setup is invoked on script startup to set various environment variables
# and create basic directories used throughout the rest of the script.
chocpkg::commands::basic_setup() {
    PACKAGES_DIR="$CHOCPKG_ROOT/packages"
    INSTALL_DIR="$CHOCPKG_ROOT/install"
    NATIVE_INSTALL_DIR="$CHOCPKG_ROOT/install.native"
    BUILD_DIR="$CHOCPKG_ROOT/build"
    NATIVE_BUILD_DIR="$CHOCPKG_ROOT/build.native"

    mkdir -p "$PACKAGES_DIR" \
             "$INSTALL_DIR" "$NATIVE_INSTALL_DIR" \
             "$BUILD_DIR" "$NATIVE_BUILD_DIR"
}

# Get the default variant for the specified package. Usually this is the
# stable variant but it can be overridden in buildenv.sh.
chocpkg::commands::default_variant() {
    local i for_package=$1
    for i in "${!LATEST_PACKAGES[@]}"; do
        local v="${LATEST_PACKAGES[$i]}"
        if [ "$v" = "$for_package" ]; then
            echo "latest"
            return
        fi
    done
    echo "stable"
}

# Given a package name given on the command line, set the PACKAGE_NAME,
# PACKAGE_VARIANT and PACKAGE_TYPE variables. Accepts different variations
# on syntax, eg.
#
#   pkgname                 # Default type and variant
#   native:pkgname          # Type explicitly specified
#   pkgname/latest          # Variant explicitly specified
#   native:pkgname/latest   # Both explicitly specified
#
chocpkg::commands::set_package_variables() {
    local package=$1

    # Allow type: prefix to specify PACKAGE_TYPE to install explicitly.
    if [[ "$package" =~ .*:.* ]]; then
        PACKAGE_TYPE=${package/%:*/}
        package=${package/#*:/}
    else
        PACKAGE_TYPE=target
    fi

    # Allow /suffix to specify a variant to build.
    if [[ "$package" =~ .*/.* ]]; then
        PACKAGE_VARIANT=${package/#*\//}
        package=${package/%\/*/}
    else
        PACKAGE_VARIANT=$(chocpkg::commands::default_variant "$package")
    fi

    PACKAGE_NAME="$package"
}

# Given a package name, find the pkgdef file associated with it, source
# the contents of the file and set various variables.
chocpkg::commands::configure_for_package() {
    if [ $# -lt 1 ]; then
        chocpkg::commands::usage
        exit 1
    fi
    chocpkg::commands::set_package_variables "$1"
    . "$CHOCPKG_ROOT/chocpkg/environment.sh"
}

chocpkg::commands::install_dependencies() {
    local i
    for i in "${!DEPENDENCIES[@]}"; do
        local dep="${DEPENDENCIES[$i]}"
        chocpkg install "$dep"
    done
}

chocpkg::commands::installed() {
    chocpkg::commands::configure_for_package "$@"
    chocpkg::environment::setup_build_environment
    do_check
}

chocpkg::commands::fetch() {
    chocpkg::commands::configure_for_package "$@"

    do_fetch
}

chocpkg::commands::build() {
    chocpkg::commands::configure_for_package "$@"
    chocpkg::commands::install_dependencies
    chocpkg fetch "$PACKAGE_NAME"

    echo =======================================================
    echo "Building $PACKAGE_NAME..."
    echo =======================================================
    echo
    cd "$PACKAGE_BUILD_DIR"

    chocpkg::environment::setup_build_environment

    if ! prebuild_setup; then
        error_exit "Failed pre-build setup step for $PACKAGE_NAME."
    fi

    do_build
}

chocpkg::commands::reinstall() {
    chocpkg::commands::configure_for_package "$@"
    chocpkg build "$PACKAGE_NAME"
    cd "$PACKAGE_BUILD_DIR"
    do_install
}

chocpkg::commands::shell() {
    chocpkg::commands::configure_for_package "$@"
    chocpkg::environment::setup_build_environment
    exec $SHELL
}

chocpkg::commands::install() {
    chocpkg::commands::configure_for_package "$@"

    # Already installed? Don't install again.
    if ! chocpkg installed "$1"; then
        chocpkg reinstall "$1"
    fi
}

chocpkg::commands::packages() {
    for sh_file in $CHOCPKG_ROOT/pkgdef/*.sh; do
        basename "${sh_file/%.sh/}"
    done
}

chocpkg::commands::package_info() {
    printf "package: %s\n" "$PACKAGE_NAME"
    printf "description: %s\n" "$PACKAGE_DESCRIPTION"

    printf "installed: "
    if chocpkg installed "$PACKAGE_NAME"; then
        printf "true\n"
    else
        printf "false\n"
    fi
    local deps=$(chocpkg dependencies "$PACKAGE_NAME")

    printf "dependencies:"
    for dep in $(chocpkg dependencies "$PACKAGE_NAME"); do
        printf " %s" "$dep"
    done
    printf "\n"

    printf "variants:"
    local i
    for i in "${!ALL_VARIANTS[@]}"; do
        printf "%s\n" "${ALL_VARIANTS[$i]}"
    done | sort | uniq | while read v; do
        printf " %s" "$v"
    done
    printf "\n"
}

chocpkg::commands::info() {
    # If a specific package name is not provided, list info on
    # all packages.
    if [ $# -lt 1 ]; then
        for package in $(chocpkg packages); do
            chocpkg info "$package"
            echo
        done
    else
        chocpkg::commands::configure_for_package "$@"
        echo "$(chocpkg::commands::package_info)"
    fi
}

chocpkg::commands::dependencies() {
    local i
    for i in "${!DEPENDENCIES[@]}"; do
        local dep="${DEPENDENCIES[$i]}"
        echo "$dep"
        chocpkg dependencies "$dep"
    done | sort | uniq
}

chocpkg::commands::usage() {
    cat <<END
Usage:
    $0 packages
        - List the names of all known packages.

    $0 info [package]
        - Display a description of the specified package, or all packages.

    $0 install <package>
        - Build and install the specified package, if not already installed.

    $0 reinstall <package>
        - Rebuild and reinstall the specified package, even if installed.

    $0 build <package>
        - Fetch and build the specified package, but do not install it.

    $0 fetch <package>
        - Download the specified package but do not build it.

END
}

chocpkg::commands::command() {
    local command=NONE
    if [ $# -gt 0 ]; then
        command="$1"
	shift
    fi
    case "$command" in
        packages)
            chocpkg::commands::packages
            ;;
        info)
            chocpkg::commands::info "$@"
            ;;
        fetch)
            chocpkg::commands::fetch "$@"
            ;;
        build)
            chocpkg::commands::build "$@"
            ;;
        reinstall)
            chocpkg::commands::reinstall "$@"
            ;;
        install)
            chocpkg::commands::install "$@"
            ;;
        dependencies)
            chocpkg::commands::dependencies "$@"
            ;;
        installed)
            chocpkg::commands::installed "$@"
            ;;
        shell)
            chocpkg::commands::shell "$@"
            ;;
        *)
            chocpkg::commands::usage
            exit 1
            ;;
    esac
}

chocpkg::commands::basic_setup

