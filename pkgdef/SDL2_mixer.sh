description "SDL audio mixing and music library"
dependencies SDL2
check_pkgconfig SDL2_mixer

variant stable fetch_download \
    http://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.1.tar.gz
variant latest fetch_hg https://hg.libsdl.org/SDL_mixer

# Disable dependencies on external libraries for sound file formats:
config_options="
    --disable-music-mod --disable-music-mp3
    --disable-music-flac-shared --disable-music-ogg-shared
"

# ...except ones we have installed:
if ! chocpkg installed ${PACKAGE_TYPE}:flac; then
    config_options+=" --disable-music-flac"
fi
if ! chocpkg installed ${PACKAGE_TYPE}:libogg; then
    config_options+=" --disable-music-ogg"
fi

# FluidSynth, if we have it.
if chocpkg installed ${PACKAGE_TYPE}:fluidsynth; then
    config_options+=" --enable-music-midi-fluidsynth"
else
    config_options+=" --disable-music-midi-fluidsynth"
fi

build_autotools $config_options
