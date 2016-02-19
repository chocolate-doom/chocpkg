
package_group::init() {
    PKGGRP_PACKAGES="$*"
}

# Package group is installed if all its packages are installed.
check_installed() {
    for package in $PKGGRP_PACKAGES; do
        chocpkg installed "$package"
    done
}

do_fetch() {
    error_exit "Can't fetch a package group, only install it."
}

do_build() {
    error_exit "Can't build a package group, only install it."
}

# We override the usual reinstall_package/install_package functions, which
# is a bit unusual, but we don't want to do the usual things (build etc.):

# Installing a package group means installing all its packages; we don't
# trigger the build step like 'install' usually does (we don't have one).
install_package() {
    for package in $PKGGRP_PACKAGES; do
        chocpkg install "$package"
    done
}

# Reinstalling a package group means reinstalling *all* its packages.
reinstall_package() {
    for package in $PKGGRP_PACKAGES; do
        chocpkg reinstall "$package"
    done
}

