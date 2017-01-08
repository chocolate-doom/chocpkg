
package_group::init() {
    dependencies "$@"
}

do_fetch() {
    chocpkg::abort "Can't fetch a package group, only install it."
}

do_build() {
    chocpkg::abort "Can't build a package group, only install it."
}

# We override the command functions for the install/reinstall commands, which
# is a bit unusual, but we don't want to do the usual things (build etc.):

# Installing a package group means installing all its packages; we don't
# trigger the build step like 'install' usually does (we don't have one).
chocpkg::commands::hook_install() {
    local i
    for i in "${!DEPENDENCIES[@]}"; do
        chocpkg install "${DEPENDENCIES[$i]}"
    done
}

# Reinstalling a package group means reinstalling *all* its packages.
chocpkg::commands::hook_reinstall() {
    local i
    for i in "${!DEPENDENCIES[@]}"; do
        chocpkg reinstall "${DEPENDENCIES[$i]}"
    done
}

chocpkg::commands::hook_dependencies() {
    local i
    for i in "${!DEPENDENCIES[@]}"; do
        local package="${DEPENDENCIES[$i]}"
        echo "$package"
        chocpkg dependencies "$package"
    done | sort | uniq
}

# Package group is installed if all its packages are installed.
chocpkg::commands::hook_installed() {
    local i
    for i in "${!DEPENDENCIES[@]}"; do
        chocpkg installed "${DEPENDENCIES[$i]}"
    done
}

