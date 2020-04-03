description "Fast console MPEG Audio Player and decoder library"
check_library mpg123
variant stable fetch_download \
    https://www.mpg123.de/download/mpg123-1.25.13.tar.bz2 \
    90306848359c793fd43b9906e52201df18775742dc3c81c06ab67a806509890a
build_autotools

