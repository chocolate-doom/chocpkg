PACKAGE_VERSION=0.28
PACKAGE_TYPE=native

check_tool pkg-config
fetch_download https://pkgconfig.freedesktop.org/releases/pkg-config-${PACKAGE_VERSION}.tar.gz
build_autotools --with-internal-glib

