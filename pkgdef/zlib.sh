PACKAGE_VERSION=1.2.8
PACKAGE_URL=http://zlib.net/zlib-${PACKAGE_VERSION}.tar.gz
PKGCONFIG_NAME=zlib

# zlib's configure script is hand-rolled and doesn't support the normal
# --host option because, well, who knows.
do_build() {
    CC="$BUILD_HOST-gcc" ./configure --prefix="$PACKAGE_INSTALL_DIR" \
                                     --static
    make
}

