description "Library compilation support script"
check_tool libtool
variant stable fetch_download \
    https://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz \
    e3bd4d5d3d025a36c21dd6af7ea818a2afcd4dfc1ea5a17b39d7854bcd0c06e3
GIT_URL=https://git.savannah.gnu.org/git/libtool.git
variant stable_git fetch_git $GIT_URL v2.4.6
variant latest fetch_git $GIT_URL master
build_autotools
