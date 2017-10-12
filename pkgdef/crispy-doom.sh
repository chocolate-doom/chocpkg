description "Crispy Doom"
dependencies SDL2 SDL2_mixer SDL2_net
# TODO: variant stable
variant latest fetch_git \
    https://github.com/fabiangreffrath/crispy-doom.git master
build_autotools
