
package_group::init() {
    PACKAGE_TYPE=package-group
    PKGGRP_PACKAGES="$*"
}

do_fetch() {
    error_exit "Can't fetch a package group, only install it."
}

do_build() {
    error_exit "Can't build a package group, only install it."
}

# We override the command functions for the install/reinstall commands, which
# is a bit unusual, but we don't want to do the usual things (build etc.):

# Installing a package group means installing all its packages; we don't
# trigger the build step like 'install' usually does (we don't have one).
cmd_install() {
    for package in $PKGGRP_PACKAGES; do
        chocpkg install "$package"
    done
}

# Reinstalling a package group means reinstalling *all* its packages.
cmd_reinstall() {
    for package in $PKGGRP_PACKAGES; do
        chocpkg reinstall "$package"
    done
}

cmd_dependencies() {
    for package in $PKGGRP_PACKAGES; do
        echo "$package"
        chocpkg dependencies "$package"
    done | sort | uniq
}

# Package group is installed if all its packages are installed.
cmd_installed() {
    for package in $PKGGRP_PACKAGES; do
        chocpkg installed "$package"
    done
}

