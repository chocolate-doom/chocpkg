description "Scripts for generating Makefile.in files"
dependencies autoconf libtool
check_tool automake
fetch_download https://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz
build_autotools
