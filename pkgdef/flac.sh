description "Library for encoding/decoding .flac lossless audio files"
check_pkgconfig flac
# We use a repacked mirror since flac is released as .xz rather than .gz:
fetch_download https://www.chocolate-doom.org/depends/flac-1.3.1.tar.gz

# Compile problems :(
build_autotools --disable-asm-optimizations
