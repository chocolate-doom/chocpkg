description "Simple DirectMedia Layer"
check_pkgconfig sdl2

variant stable fetch_download \
    https://www.libsdl.org/release/SDL2-2.0.12.tar.gz \
    349268f695c02efbc9b9148a70b85e58cefbbf704abd3e91be654db7f1e2c863
GIT_URL=https://github.com/libsdl-org/SDL.git
variant stable_git fetch_git $GIT_URL release-2.0.12
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
