description "Conservative, historically-accurate Doom source port"
dependencies SDL2 SDL2_mixer SDL2_net
variant stable fetch_download \
    https://www.chocolate-doom.org/downloads/3.0.0/chocolate-doom-3.0.0.tar.gz \
    73aea623930c7d18a7a778eea391e1ddfbe90ad1ac40a91b380afca4b0e1dab8
variant latest fetch_git \
    https://github.com/chocolate-doom/chocolate-doom.git
build_autotools
