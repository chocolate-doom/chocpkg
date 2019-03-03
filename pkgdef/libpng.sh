description "Library for reading/writing .png image files"
dependencies zlib
check_pkgconfig libpng
# We maintain a mirror since libpng is only downloadable via Sourceforge:
variant stable fetch_download $CHOCPKG_MIRRORS/libpng-1.6.10.tar.gz \
    b0206a22b49c91fc5521b2cfb1c251433a37aed0a645bc504ab3d061f27e4d51
variant latest fetch_git https://github.com/glennrp/libpng.git libpng16
build_autotools
