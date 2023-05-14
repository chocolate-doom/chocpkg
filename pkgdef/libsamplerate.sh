description "Library for high quality audio resampling"
check_pkgconfig samplerate
variant stable fetch_download \
    http://www.mega-nerd.com/SRC/libsamplerate-0.1.9.tar.gz \
    0a7eb168e2f21353fb6d84da152e4512126f7dc48ccb0be80578c565413444c1
GIT_URL=https://github.com/libsndfile/libsamplerate.git
variant stable_git fetch_git $GIT_URL 0.1.9
variant latest fetch_git $GIT_URL master
build_autotools
