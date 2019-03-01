description "MPEG Audio Decoder library"
check_library mad
variant stable fetch_git https://github.com/chocolate-doom/libmad.git
build_autotools

