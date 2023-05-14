description "Library for reading/writing .png image files"
dependencies zlib
check_pkgconfig libpng
# We maintain a mirror since libpng is only downloadable via Sourceforge:
variant stable fetch_download $CHOCPKG_MIRRORS/libpng-1.6.39.tar.gz \
    af4fb7f260f839919e5958e5ab01a275d4fe436d45442a36ee62f73e5beb75ba
GIT_URL=https://github.com/glennrp/libpng.git
variant latest fetch_git $GIT_URL libpng16
variant stable_git fetch_git $GIT_URL v1.6.10
build_autotools
