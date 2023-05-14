description "Real-time sound font software synthesizer"
check_pkgconfig fluidsynth
variant stable fetch_download $CHOCPKG_MIRRORS/fluidsynth-1.1.6.tar.gz \
    50853391d9ebeda9b4db787efb23f98b1e26b7296dd2bb5d0d96b5bccee2171c
GIT_URL=https://github.com/FluidSynth/fluidsynth.git
variant stable_git fetch_git $GIT_URL v1.1.6
variant latest fetch_git $GIT_URL master
dependencies glib
build_autotools
