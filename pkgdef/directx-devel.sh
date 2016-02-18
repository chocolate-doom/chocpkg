PACKAGE_URL=https://www.libsdl.org/extras/win32/common/directx-devel.tar.gz
IS_TAR_BOMB=true

do_build() {
    true
}

do_install() {
    cp -R include lib "$PACKAGE_INSTALL_DIR"
}

