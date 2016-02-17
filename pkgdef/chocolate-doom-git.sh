PACKAGE_TYPE=git
GIT_URL=https://github.com/fragglet/chocolate-doom.git
GIT_BRANCH=sdl2-branch
DEPENDENCIES="SDL2 SDL2_mixer SDL2_net"

prebuild_setup() {
    mkdir -p autotools
    aclocal -I "$INSTALL_DIR/share/aclocal"
    autoheader
    automake -a -c
    autoconf
    automake
}

