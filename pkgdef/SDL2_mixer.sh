PACKAGE_VERSION=2.0.1
PACKAGE_URL=http://www.libsdl.org/projects/SDL_mixer/release/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz
PKGCONFIG_NAME=SDL2_mixer

# Disable dependencies on external libraries for sound file formats:
PACKAGE_CONFIGURE_OPTS="
    --disable-music-mod --disable-music-mp3
    --disable-music-flac-shared --disable-music-ogg-shared
"

# ...except ones we have installed:
if ! chocpkg installed flac; then
    PACKAGE_CONFIGURE_OPTS="$PACKAGE_CONFIGURE_OPTS --disable-music-flac"
fi
if ! chocpkg installed libogg; then
    PACKAGE_CONFIGURE_OPTS="$PACKAGE_CONFIGURE_OPTS --disable-music-ogg"
fi

