description "Library for decoding Ogg Vorbis codec files"
dependencies libogg
check_pkgconfig vorbis
fetch_download http://www.chocolate-doom.org/depends/libvorbis-1.3.4.tar.gz
build_autotools
