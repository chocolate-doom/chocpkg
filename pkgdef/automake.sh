description "Scripts for generating Makefile.in files"
dependencies autoconf libtool
check_tool automake
fetch_download https://ftp.gnu.org/gnu/automake/automake-1.16.tar.gz \
               80da43bb5665596ee389e6d8b64b4f122ea4b92a685b1dbd813cd1f0e0c2d83f
build_autotools
