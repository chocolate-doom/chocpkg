description "Fast console MPEG Audio Player and decoder library"
check_library mpg123
variant stable fetch_download \
    https://www.mpg123.de/download/mpg123-1.26.3.tar.bz2 \
    30c998785a898f2846deefc4d17d6e4683a5a550b7eacf6ea506e30a7a736c6e
build_autotools

