description "MPEG Audio Decoder library"
check_library mad
variant stable fetch_download \
    ftp://ftp.mars.org/pub/mpeg/libmad-0.15.1b.tar.gz \
    bbfac3ed6bfbc2823d3775ebb931087371e142bb0e9bb1bee51a76a6e0078690
build_autotools

prebuild_setup() {
  cp configure configure.orig
  # libmad hasn't had a new release in 14 years, so we must manually
  # patch the configure script to remove all these compiler flags which
  # don't work any more (especially in clang):
  sed <configure.orig >configure '
    s/-fforce-mem//
    s/-fthread-jumps//
    s/-fcse-follow-jumps//
    s/-fcse-skip-blocks//
    s/-fregmove//
    s/-fexpensive-optimizations//
    s/-fschedule-insns2//
    s/-fstrength-reduce//
    s/-march=i486//
  '
}

