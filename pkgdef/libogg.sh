description "Library for reading .ogg container files"
check_pkgconfig ogg
fetch_download http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz
build_autotools
