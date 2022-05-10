description "SDL audio mixing and music library"
dependencies SDL2
check_pkgconfig SDL2_mixer

variant stable fetch_download \
    https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.4.tar.gz \
    b4cf5a382c061cd75081cf246c2aa2f9df8db04bdda8dcdc6b6cca55bede2419
GIT_URL=https://github.com/libsdl-org/SDL_mixer.git
variant stable_git fetch_git $GIT_URL release-2.0.4
variant latest fetch_git $GIT_URL main

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
