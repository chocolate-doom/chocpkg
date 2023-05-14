description "Library for encoding/decoding .flac lossless audio files"
dependencies libogg
check_pkgconfig flac
# We use a repacked mirror since flac is released as .xz rather than .gz:
variant stable fetch_download $CHOCPKG_MIRRORS/flac-1.4.2.tar.gz \
    eb35ea3a4ddf6308c21f6a47699a43e9349ca432409242e1852f483fe5898a18
GIT_URL=https://github.com/xiph/flac.git
variant stable_git fetch_git $GIT_URL 1.4.2
variant latest fetch_git $GIT_URL master

# Compile problems :(
build_autotools --disable-asm-optimizations --disable-cpplibs \
                --disable-programs --disable-examples \
                --disable-oggtest
