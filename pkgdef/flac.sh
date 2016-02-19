PACKAGE_VERSION=1.3.1

check_pkgconfig flac
fetch_download http://www.chocolate-doom.org/depends/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz

# Compile problems :(
build_autotools --disable-asm-optimizations

