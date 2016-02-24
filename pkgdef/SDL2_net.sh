PACKAGE_VERSION=2.0.1

dependencies SDL2
check_pkgconfig SDL2_net
fetch_download http://www.libsdl.org/projects/SDL_net/release/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz
build_autotools

