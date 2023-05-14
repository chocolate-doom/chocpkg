description "Simple DirectMedia Layer"
check_pkgconfig sdl2

variant stable fetch_download \
    https://www.libsdl.org/release/SDL2-2.26.5.tar.gz \
    ad8fea3da1be64c83c45b1d363a6b4ba8fd60f5bde3b23ec73855709ec5eabf7
GIT_URL=https://github.com/libsdl-org/SDL.git
variant stable_git fetch_git $GIT_URL release-2.26.5
variant latest fetch_git $GIT_URL SDL2

config_options=

# Many OS X systems have the Quartz X11 server installed, but
# we probably don't want to use it.
if [ $(uname) = "Darwin" ]; then
    config_options+=" --disable-video-x11"
fi

# When targeting Windows, we need to install the directx headers first.
if [ $(uname) = "Cygwin" ] || [[ "$BUILD_HOST" = *mingw* ]]; then
    dependencies directx-devel
    config_options+=" --disable-directx"
fi

# Disable assembly to avoid depending on SIMD stuff.
if [[ "$BUILD_HOST" = *-*-emscripten ]]; then
    config_options+=" --disable-assembly"
fi

# For SDL, we do an out-of-tree build in a subdirectory, since the configure
# script can complain otherwise.
AUTOTOOLS_BUILD_PATH=build-artifacts
build_autotools $config_options
