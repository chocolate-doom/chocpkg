description "Simple DirectMedia Layer"
check_pkgconfig sdl2

variant stable fetch_download http://www.libsdl.org/release/SDL2-2.0.4.tar.gz
variant latest fetch_hg https://hg.libsdl.org/SDL/

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

build_autotools $config_options
