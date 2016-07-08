description "Real-time sound font software synthesizer"
check_pkgconfig fluidsynth
fetch_download https://www.chocolate-doom.org/depends/fluidsynth-1.1.6.tar.gz
dependencies glib
build_autotools
