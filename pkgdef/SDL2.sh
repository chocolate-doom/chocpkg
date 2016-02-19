
PACKAGE_VERSION=2.0.4

check_pkgconfig sdl2
fetch_download http://www.libsdl.org/release/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz

config_options=

# Many OS X systems have the Quartz X11 server installed, but
# we probably don't want to use it.
if [ $(uname) = "Darwin" ]; then
    config_options+=" --disable-video-x11"
fi

# When targeting Windows, we need to install the directx headers first.
if [ $(uname) = "Cygwin" ] || pattern_match "*mingw*" "$BUILD_HOST"; then
    DEPENDENCIES="directx-devel"
    config_options+=" --disable-directx"
fi

build_autotools $config_options

