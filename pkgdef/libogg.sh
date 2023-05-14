description "Library for reading .ogg container files"
check_pkgconfig ogg
variant stable fetch_download \
    https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.2.tar.gz \
    e19ee34711d7af328cb26287f4137e70630e7261b17cbe3cd41011d73a654692
GIT_URL=https://github.com/xiph/ogg.git
variant stable_git fetch_git $GIT_URL v1.3.2
variant latest fetch_git $GIT_URL master
build_autotools
