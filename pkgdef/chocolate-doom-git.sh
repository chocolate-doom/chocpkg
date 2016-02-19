dependencies SDL2 SDL2_mixer SDL2_net
fetch_git https://github.com/fragglet/chocolate-doom.git sdl2-branch
build_autotools

prebuild_setup() {
    autoreconf -fi
}

