
check_pkgconfig::init() {
    PKGCONFIG_NAME=$1
}

# Function that returns true if the package is installed.
check_installed() {
    if ! have_tool pkg-config; then
        error_exit "pkg-config not installed; please run:" \
                   "    chocpkg install pkg-config"
    fi
    pkg-config --exists "$PKGCONFIG_NAME"
}

