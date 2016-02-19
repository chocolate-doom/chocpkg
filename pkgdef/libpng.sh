PACKAGE_VERSION=1.6.10

dependencies zlib
check_pkgconfig libpng
fetch_download http://www.chocolate-doom.org/depends/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz
build_autotools

