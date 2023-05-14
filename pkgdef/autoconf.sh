description "Scripts for generating configure scripts"
check_tool autoconf
fetch_download https://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.gz \
               431075ad0bf529ef13cb41e9042c542381103e80015686222b8a9d4abef42a1c
build_autotools
