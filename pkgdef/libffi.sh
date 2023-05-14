description "Foreign function interface library"
check_pkgconfig libffi
variant stable fetch_download \
    https://www.mirrorservice.org/sites/sourceware.org/pub/libffi/libffi-3.4.3.tar.gz \
    4416dd92b6ae8fcb5b10421e711c4d3cb31203d77521a77d85d0102311e6c3b8
GIT_URL=https://github.com/libffi/libffi.git
variant stable_git fetch_git $GIT_URL v3.4.3
variant latest fetch_git $GIT_URL master
build_autotools
