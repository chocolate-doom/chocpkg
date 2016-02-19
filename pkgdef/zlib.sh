PACKAGE_VERSION=1.2.8

check_pkgconfig zlib
fetch_download http://zlib.net/zlib-${PACKAGE_VERSION}.tar.gz
build_autotools

# zlib's configure script is hand-rolled and doesn't support the normal
# --host option because, well, who knows.
do_build() {
    if [ ! -z "$BUILD_HOST" ]; then
        export CC="$BUILD_HOST-gcc"
    fi
    ./configure --prefix="$PACKAGE_INSTALL_DIR" --static
    make
}

