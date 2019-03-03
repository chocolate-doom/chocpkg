# This file is included to import/evaluate the package file. Before it is
# imported, the following variables must be initialized:
#
#   PACKAGE_NAME    - Filename of package file.
#   PACKAGE_TYPE    - Whether to configure for native or target build.
#   PACKAGE_VARIANT - Variant to control origin for sourcing package.

. "$CHOCPKG_ROOT/chocpkg/modules.sh"

CHOCPKG_MIRRORS=https://raw.githubusercontent.com/chocolate-doom/chocpkg-mirrors/master

description() {
    PACKAGE_DESCRIPTION="$*"
}

# Function invoked before a package is built to set up the build environment,
# if necessary. Can be overridden by pkgdef files.
prebuild_setup() {
    true
}

dependencies() {
    DEPENDENCIES+=("$@")
}

variant() {
    local for_variant=$1; shift
    if [ "$PACKAGE_VARIANT" = "$for_variant" ]; then
        "$@"
    fi
    ALL_VARIANTS+=("$for_variant")
}

chocpkg::environment::set_dependencies_native() {
    local i
    for i in ${!DEPENDENCIES[@]}; do
        local dep="${DEPENDENCIES[$i]}"
        if [[ "$PACKAGE_TYPE" = native ]] && ! [[ "$dep" =~ native: ]]; then
            DEPENDENCIES[$i]="native:$dep"
        fi
        i=$((i + 1))
    done
}

# Check if the given variant was declared in the package file.
chocpkg::environment::valid_variant() {
    local i for_variant=$1
    for i in "${!ALL_VARIANTS[@]}"; do
        local v="${ALL_VARIANTS[$i]}"
        if [ "$v" = "$for_variant" ]; then
            return 0
        fi
    done
    false
}

# Set the PACKAGE_BUILD_DIR and PACKAGE_INSTALL_DIR directories for the given
# package. These control where we extract the source code to, and where we
# "make install" the built results into, respectively. We use different
# directories for target and native builds.
chocpkg::environment::set_package_dirs() {
    case "$PACKAGE_TYPE" in
        target)
            PACKAGE_INSTALL_DIR="$INSTALL_DIR"
            PACKAGE_BUILD_DIR="$BUILD_DIR/$PACKAGE_DIR_NAME"
            ;;
        native)
            PACKAGE_INSTALL_DIR="$NATIVE_INSTALL_DIR"
            PACKAGE_BUILD_DIR="$NATIVE_BUILD_DIR/$PACKAGE_DIR_NAME"
            ;;
        *)
            chocpkg::abort "Unknown package type $PACKAGE_TYPE"
            ;;
    esac
}

# Having set PACKAGE_NAME, PACKAGE_VARIANT and PACKAGE_TYPE, evaluate the
# package file by importing it as a shell script.
chocpkg::environment::load_package_file() {
    # Defaults before loading package file.
    DEPENDENCIES=()
    ALL_VARIANTS=()
    PACKAGE_DESCRIPTION="Package $PACKAGE_NAME"
    PACKAGE_DIR_NAME=$PACKAGE_NAME

    local pkg_file="$CHOCPKG_ROOT/pkgdef/$PACKAGE_NAME.sh"
    if [ ! -e "$pkg_file" ]; then
        chocpkg::abort "Package file $PACKAGE_NAME.sh not found."
    fi
    . "$pkg_file"

    # If the package defines no variants, we assume it only has stable.
    if [ "${#ALL_VARIANTS[@]}" -eq 0 ]; then
        ALL_VARIANTS=(stable)
    fi

    if ! chocpkg::environment::valid_variant "$PACKAGE_VARIANT"; then
        chocpkg::abort "Unknown variant $PACKAGE_VARIANT for $PACKAGE_NAME."
    fi

    # When installing a native package, all its dependencies are
    # necessarily native as well.
    if [ "$PACKAGE_TYPE" = native ]; then
        chocpkg::environment::set_dependencies_native
    fi

    chocpkg::environment::set_package_dirs
}

# setup_build_environment sets environment variables for build. This is
# deliberately only done when needed, as otherwise the value could affect
# child builds when recursing to build dependent packages.
chocpkg::environment::setup_build_environment() {
    CPPFLAGS="-I$PACKAGE_INSTALL_DIR/include"
    LDFLAGS="-L$PACKAGE_INSTALL_DIR/lib ${LDFLAGS:-}"
    export CPPFLAGS LDFLAGS

    # ACLOCAL_PATH is a special case: we include the aclocal paths from both
    # target and native, so that it is possible to get the pkg-config macros.
    ACLOCAL_PATH="$NATIVE_INSTALL_DIR/share/aclocal:${ACLOCAL_PATH:-}"
    if [ "$PACKAGE_TYPE" = "target" ]; then
        ACLOCAL_PATH="$INSTALL_DIR/share/aclocal:${ACLOCAL_PATH:-}"
    fi
    export ACLOCAL_PATH

    # Same with PATH as for ACLOCAL_PATH. We can always run tools from
    # install.native, but only from target install if we're building for it.
    PATH="$NATIVE_INSTALL_DIR/bin:$PATH"
    if [ "$PACKAGE_TYPE" = "target" ]; then
        PATH="$INSTALL_DIR/bin:$PATH"
    fi

    # We need to find where to look for pkg-config .pc files:
    PKG_CONFIG_PATH="$PACKAGE_INSTALL_DIR/lib/pkgconfig:${PKG_CONFIG_PATH:-}"
    export PKG_CONFIG_PATH

    # When cross-compiling, reconfigure pkg-config to not look for .pc
    # files in the standard system directories; only in our own build
    # directory. It may be that a library is installed on the system
    # but that is useless if it is for the wrong architecture.
    if $IS_CROSS_COMPILE && [ "$PACKAGE_TYPE" = "target" ]; then
        export PKG_CONFIG_LIBDIR=
    fi

    # Python modules get installed into a special chocpkg-specific
    # directory; see the build_python module for more details.
    export PYTHONPATH="$NATIVE_INSTALL_DIR/lib/chocpkg-python:${PYTHONPATH:-}"
    if [ "$PACKAGE_TYPE" = "target" ]; then
        PYTHONPREFIXPATHS="$INSTALL_DIR/lib/chocpkg-python:$PYTHONPATH"
    fi
}

chocpkg::environment::load_package_file

