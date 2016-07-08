description "Library for decoding Ogg Vorbis codec files"
dependencies libogg
check_pkgconfig vorbis
fetch_download http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.tar.gz
build_autotools
