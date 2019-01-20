
check_library::init() {
    PACKAGE_INSTALLED_LIB=$1
}

# Function that returns true if a specified C library is installed.
do_check() {
  # TODO: A better way to choose compiler command?
  ${CC:-gcc} \
      -l$PACKAGE_INSTALLED_LIB $LDFLAGS \
      -o$PACKAGE_INSTALL_DIR/__install_check \
      -x c <( echo "int main() {}") \
      2>/dev/null
}

