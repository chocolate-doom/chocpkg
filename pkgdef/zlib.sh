description "Library for compressing/decompressing GZIP files"
check_pkgconfig zlib
variant stable fetch_download http://www.zlib.net/fossils/zlib-1.2.13.tar.gz \
               b3a24de97a8fdbc835b9833169501030b8977031bcb54b3b3ac13740f846ab30
GIT_URL=https://github.com/madler/zlib.git
variant stable_git fetch_git $GIT_URL v1.2.13
variant latest fetch_git $GIT_URL master
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

