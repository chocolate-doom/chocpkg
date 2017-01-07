description "Library for compressing/decompressing GZIP files"
check_pkgconfig zlib
fetch_download http://zlib.net/zlib-1.2.10.tar.gz \
               8d7e9f698ce48787b6e1c67e6bff79e487303e66077e25cb9784ac8835978017
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

