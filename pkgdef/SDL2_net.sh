description "SDL networking library"
dependencies SDL2
check_pkgconfig SDL2_net
fetch_download http://www.libsdl.org/projects/SDL_net/release/SDL2_net-2.0.1.tar.gz
build_autotools
