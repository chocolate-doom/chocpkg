description "SDL audio mixing and music library"
dependencies SDL2
check_pkgconfig SDL2_mixer

variant stable fetch_download \
    https://github.com/libsdl-org/SDL_mixer/releases/download/release-2.6.3/SDL2_mixer-2.6.3.tar.gz \
    7a6ba86a478648ce617e3a5e9277181bc67f7ce9876605eea6affd4a0d6eea8f
GIT_URL=https://github.com/libsdl-org/SDL_mixer.git
variant stable_git fetch_git $GIT_URL release-2.6.3
variant latest fetch_git $GIT_URL SDL2

# Disable dependencies on external libraries for sound file formats:
config_options="
    --disable-music-mod --disable-music-flac-shared
    --disable-music-ogg-shared
    --disable-music-mp3-mpg123-shared
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

if chocpkg installed ${PACKAGE_TYPE}:libmpg123; then
    config_options+=" --enable-music-mp3 --disable-music-mp3-mad-gpl --enable-music-mp3-mpg123"
elif chocpkg installed ${PACKAGE_TYPE}:libmad; then
    config_options+=" --enable-music-mp3 --enable-music-mp3-mad-gpl"
else
    config_options+=" --disable-music-mp3 --disable-music-mp3-mad-gpl"
fi

build_autotools $config_options
