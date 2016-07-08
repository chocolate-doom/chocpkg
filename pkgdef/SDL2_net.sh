description "SDL networking library"
dependencies SDL2
check_pkgconfig SDL2_net
variant stable fetch_download \
    https://www.libsdl.org/projects/SDL_net/release/SDL2_net-2.0.1.tar.gz
variant latest fetch_hg https://hg.libsdl.org/SDL_net
build_autotools
