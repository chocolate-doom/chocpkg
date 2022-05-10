description "SDL networking library"
dependencies SDL2
check_pkgconfig SDL2_net
variant stable fetch_download \
    https://www.libsdl.org/projects/SDL_net/release/SDL2_net-2.0.1.tar.gz \
    15ce8a7e5a23dafe8177c8df6e6c79b6749a03fff1e8196742d3571657609d21
GIT_URL=https://github.com/libsdl-org/SDL_net.git
variant stable_git fetch_git $GIT_URL release-2.0.1
variant latest fetch_git $GIT_URL main
build_autotools
