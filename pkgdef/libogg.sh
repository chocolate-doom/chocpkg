description "Library for reading .ogg container files"
check_pkgconfig ogg
variant stable fetch_download \
    https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.2.tar.gz \
    e19ee34711d7af328cb26287f4137e70630e7261b17cbe3cd41011d73a654692
variant latest fetch_git https://github.com/xiph/ogg.git master
build_autotools
