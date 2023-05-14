description "SDL networking library"
dependencies SDL2
check_pkgconfig SDL2_net
variant stable fetch_download \
    https://www.libsdl.org/projects/SDL_net/release/SDL2_net-2.2.0.tar.gz \
    4e4a891988316271974ff4e9585ed1ef729a123d22c08bd473129179dc857feb
GIT_URL=https://github.com/libsdl-org/SDL_net.git
variant stable_git fetch_git $GIT_URL release-2.0.1
variant latest fetch_git $GIT_URL main
build_autotools
