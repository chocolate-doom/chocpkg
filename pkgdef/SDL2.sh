PACKAGE_VERSION=2.0.4
PACKAGE_URL=http://www.libsdl.org/release/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz
PKGCONFIG_NAME=sdl2

# Many OS X systems have the Quartz X11 server installed, but
# we probably don't want to use it.
if [ $(uname) = "Darwin" ]; then
    PACKAGE_CONFIGURE_OPTS=--disable-video-x11
fi

# When targeting Windows, we need to install the directx headers first.
if [ $(uname) = "Cygwin" ] || pattern_match "*mingw*" "$BUILD_HOST"; then
    DEPENDENCIES="directx-devel"
fi

