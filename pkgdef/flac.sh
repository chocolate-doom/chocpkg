description "Library for encoding/decoding .flac lossless audio files"
dependencies libogg
check_pkgconfig flac
# We use a repacked mirror since flac is released as .xz rather than .gz:
variant stable fetch_download $CHOCPKG_MIRRORS/flac-1.3.1.tar.gz \
    4ae2c8ee48b3ae52635e543b1e64b58f5dcb8d69e1e18257da82f800cb754861
GIT_URL=https://github.com/xiph/flac.git
variant stable_git fetch_git $GIT_URL 1.3.1
variant latest fetch_git $GIT_URL master

# Compile problems :(
build_autotools --disable-asm-optimizations --disable-cpplibs
