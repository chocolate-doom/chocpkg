PACKAGE_VERSION=1.3.4

dependencies libogg
check_pkgconfig vorbis
fetch_download http://www.chocolate-doom.org/depends/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz
build_autotools

