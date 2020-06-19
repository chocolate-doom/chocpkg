description "Fast console MPEG Audio Player and decoder library"
check_library mpg123
variant stable fetch_download \
    https://www.mpg123.de/download/mpg123-1.26.1.tar.bz2 \
    74d6629ab7f3dd9a588b0931528ba7ecfa989a2cad6bf53ffeef9de31b0fe032
build_autotools

