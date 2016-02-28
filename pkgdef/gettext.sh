description "gettext localization library"
check_tool gettext
fetch_download https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.7.tar.gz
build_autotools --disable-java
