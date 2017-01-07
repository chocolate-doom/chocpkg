
check_tool::init() {
    PACKAGE_INSTALLED_TOOL=$1
}

# Function that returns true if the package is installed.
do_check() {
    chocpkg::have_tool "$PACKAGE_INSTALLED_TOOL"
}

