description "gettext localization library"
check_tool gettext
variant stable fetch_download \
    https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.7.tar.gz \
    5386d2a40500295783c6a52121adcf42a25519e2d23675950619c9e69558c23f
GIT_URL=https://git.savannah.gnu.org/git/gettext.git
variant stable_git fetch_git $GIT_URL v0.19.7
variant latest fetch_git $GIT_URL master
build_autotools --disable-java
