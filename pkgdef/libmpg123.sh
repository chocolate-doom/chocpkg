description "Fast console MPEG Audio Player and decoder library"
check_library mpg123
# We repack the source tarball since it is only available in tar.bz2 format:
variant stable fetch_download \
    $CHOCPKG_MIRRORS/mpg123-1.25.13.tar.gz \
    0bf1a85129fc3faf6a84eaf874d8eda876a15774e0ebb801aa0ab9f29508cf89
build_autotools

