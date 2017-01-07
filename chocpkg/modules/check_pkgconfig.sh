
check_pkgconfig::init() {
    PKGCONFIG_NAME=$1

    # If we're using pkg-config to check, we need to install pkg-config
    # first.
    dependencies native:pkg-config
}

# Function that returns true if the package is installed.
do_check() {
    if ! chocpkg::have_tool pkg-config; then
        chocpkg::abort "pkg-config not installed; please run:" \
                   "    chocpkg install native:pkg-config"
    fi
    pkg-config --exists "$PKGCONFIG_NAME"
}

