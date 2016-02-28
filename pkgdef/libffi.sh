description "Foreign function interface library"
check_pkgconfig libffi
fetch_download https://www.mirrorservice.org/sites/sourceware.org/pub/libffi/libffi-3.2.tar.gz
build_autotools
