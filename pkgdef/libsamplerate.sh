PACKAGE_VERSION=0.1.8

check_pkgconfig samplerate
fetch_download http://www.chocolate-doom.org/depends/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz
build_autotools

