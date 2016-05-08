description "SDL imaging library"
dependencies SDL2
check_pkgconfig SDL2_image
fetch_download https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.1.tar.gz
build_autotools --disable-imageio
