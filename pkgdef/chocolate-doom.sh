description "Conservative, historically-accurate Doom source port"
dependencies SDL2 SDL2_mixer SDL2_net
variant latest fetch_git \
    https://github.com/chocolate-doom/chocolate-doom.git sdl2-branch
build_autotools
