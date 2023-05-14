description "Library for reading .ogg container files"
check_pkgconfig ogg
variant stable fetch_download \
    https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.4.tar.gz \
    fe5670640bd49e828d64d2879c31cb4dde9758681bb664f9bdbf159a01b0c76e
GIT_URL=https://github.com/xiph/ogg.git
variant stable_git fetch_git $GIT_URL v1.3.4
variant latest fetch_git $GIT_URL master
build_autotools
