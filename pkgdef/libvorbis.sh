description "Library for decoding Ogg Vorbis codec files"
dependencies libogg
check_pkgconfig vorbis
variant stable fetch_download \
    https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.5.tar.gz \
    6efbcecdd3e5dfbf090341b485da9d176eb250d893e3eb378c428a2db38301ce
GIT_URL=https://github.com/xiph/vorbis.git
variant stable_git fetch_git $GIT_URL v1.3.5
variant latest fetch_git $GIT_URL master
build_autotools
