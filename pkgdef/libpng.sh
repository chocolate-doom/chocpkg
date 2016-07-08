description "Library for reading/writing .png image files"
dependencies zlib
check_pkgconfig libpng
# We maintain a mirror since libpng is only downloadable via Sourceforge:
fetch_download https://www.chocolate-doom.org/depends/libpng-1.6.10.tar.gz
build_autotools
