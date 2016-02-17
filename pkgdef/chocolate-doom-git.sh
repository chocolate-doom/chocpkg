PACKAGE_TYPE=git
GIT_URL=https://github.com/fragglet/chocolate-doom.git
GIT_BRANCH=sdl2-branch
DEPENDENCIES="SDL2 SDL2_mixer SDL2_net"

prebuild_setup() {
    bash ./autogen.sh
}

