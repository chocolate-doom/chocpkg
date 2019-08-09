description "Competition Doom port used for speedruning"
dependencies SDL2 SDL2_mixer SDL2_net
variant stable fetch_download \
    https://doom.com.hr/cndoom/packages/cndoom.tar.gz \
9242c03c8ccf9d126667c5b2d92dc242e5ff109e0329be5bf05f43d53855fe73
variant latest fetch_git \
    https://github.com/fx02/cndoom.git
build_autotools
