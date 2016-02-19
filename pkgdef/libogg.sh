PACKAGE_VERSION=1.3.1

check_pkgconfig ogg
fetch_download http://www.chocolate-doom.org/depends/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz
build_autotools

