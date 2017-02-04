description "Conservative, historically-accurate Doom source port"
dependencies SDL2 SDL2_mixer SDL2_net
variant stable fetch_download \
    https://www.chocolate-doom.org/downloads/3.0.0-beta1/chocolate-doom-3.0.0-beta1.tar.gz \
    62362fbe99aac07a8bb610a30e7318741cd007eb8807500994a25ee488025020
variant latest fetch_git \
    https://github.com/chocolate-doom/chocolate-doom.git sdl2-branch
build_autotools
