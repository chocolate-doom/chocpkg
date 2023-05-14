description "Fast console MPEG Audio Player and decoder library"
check_library mpg123
variant stable fetch_download \
    https://www.mpg123.de/download/mpg123-1.31.3.tar.bz2 \
    1ca77d3a69a5ff845b7a0536f783fee554e1041139a6b978f6afe14f5814ad1a
build_autotools

