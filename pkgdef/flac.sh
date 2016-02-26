description "Library for encoding/decoding .flac lossless audio files"
check_pkgconfig flac
fetch_download http://www.chocolate-doom.org/depends/flac-1.3.1.tar.gz

# Compile problems :(
build_autotools --disable-asm-optimizations
