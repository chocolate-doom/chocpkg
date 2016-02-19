PACKAGE_VERSION=2.0.1

check_pkgconfig SDL2_mixer
fetch_download http://www.libsdl.org/projects/SDL_mixer/release/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz

# Disable dependencies on external libraries for sound file formats:
config_options="
    --disable-music-mod --disable-music-mp3
    --disable-music-flac-shared --disable-music-ogg-shared
"

# ...except ones we have installed:
if ! chocpkg installed flac; then
    config_options+=" --disable-music-flac"
fi
if ! chocpkg installed libogg; then
    config_options+=" --disable-music-ogg"
fi

build_autotools $config_options

