PACKAGE_TYPE=native

check_tool pkg-config
fetch_download https://pkgconfig.freedesktop.org/releases/pkg-config-0.28.tar.gz
build_autotools --with-internal-glib

