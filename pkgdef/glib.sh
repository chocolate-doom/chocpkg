description "GNOME glib core utility library"
check_pkgconfig glib
fetch_download http://www.chocolate-doom.org/depends/glib-2.47.6.tar.gz
dependencies libffi gettext zlib
build_autotools --with-pcre=internal
