description "Library for compressing/decompressing GZIP files"
check_pkgconfig zlib
fetch_download http://www.zlib.net/fossils/zlib-1.2.11.tar.gz \
               c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1
build_autotools

# zlib's configure script is hand-rolled and doesn't support the normal
# --host option because, well, who knows.
do_build() {
    if [ ! -z "$BUILD_HOST" ]; then
        export CC="$BUILD_HOST-gcc"
    fi
    # Don't include -lc when building libraries. It's unclear why zlib does
    # this by default, but it certainly doesn't work for Mingw compiles.
    LDSHAREDLIBC="" ./configure --prefix="$PACKAGE_INSTALL_DIR"
    make
}

