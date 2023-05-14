description "Conservative, historically-accurate Doom source port"
dependencies SDL2 SDL2_mixer SDL2_net
variant stable fetch_download \
    https://www.chocolate-doom.org/downloads/3.0.1/chocolate-doom-3.0.1.tar.gz \
    d435d6177423491d60be706da9f07d3ab4fabf3e077ec2a3fc216e394fcfc8c7
GIT_URL=https://github.com/chocolate-doom/chocolate-doom.git
variant stable_git fetch_git $GIT_URL chocolate-doom-3.0.1
variant latest fetch_git $GIT_URL
build_autotools
