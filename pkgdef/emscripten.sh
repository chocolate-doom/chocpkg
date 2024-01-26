description "Emscripten build environment"

SDL2_PACKAGE_CONFIG="
prefix=/
exec_prefix=/
libdir=/
includedir=/

Name: sdl2
Description: sdl2
Version: 2.20.0
Requires:
Conflicts:
Libs: -sUSE_SDL=2 -flto -sASYNCIFY -sENVIRONMENT=web
Cflags: -sUSE_SDL=2
"

do_fetch() {
    check_tool emcc
    mkdir -p "$PACKAGE_BUILD_DIR"
    echo "This is just a dummy directory" > "$PACKAGE_BUILD_DIR/README"
}

do_build() {
    true
}

make_wrapper_script() {
    local toolname emtoolname path
    toolname="$1"
    emtoolname="$2"
    path="$PACKAGE_INSTALL_DIR/bin/wasm32-unknown-emscripten-$toolname"
    mkdir -p "$PACKAGE_INSTALL_DIR/bin"
    (echo "#!/bin/bash"
     echo "export EM_CACHE=$PACKAGE_INSTALL_DIR/emscripten_cache"
     echo "export EM_FROZEN_CACHE="
     echo "exec $emtoolname \"\$@\"") > "$path"
    chmod a+rx "$path"
}

do_install() {
    # Emscripten has its own patched version of SDL2 that will get installed
    # automatically if -sUSE_SDL=2 is provided on the command line. By
    # installing a "fake" pkg-config file that just supplies this argument,
    # we short-circuit the build for the normal SDL package.
    mkdir -p "$PACKAGE_INSTALL_DIR/lib/pkgconfig"
    echo "$SDL2_PACKAGE_CONFIG" > "$PACKAGE_INSTALL_DIR/lib/pkgconfig/sdl2.pc"
    # TODO: Add pkg-config files for other libraries emscripten supports.

    # Emscripten is a weird beast, and wants us to use all its weird tools
    # (emconfigure, emmake, etc.). Instead of that, we define a "fake" system
    # named wasm32-unknown-emscripten and create wrapper scripts for all the
    # necessary compile tools. Then we can build like any other normal
    # cross-compile system -- mostly.
    make_wrapper_script ar     emar
    make_wrapper_script gcc    emcc
    make_wrapper_script g++    em++
    make_wrapper_script ld     emcc
    make_wrapper_script nm     emnm
    make_wrapper_script ranlib emranlib

    echo "Wrapper scripts installed."
}

check_tool wasm32-unknown-emscripten-gcc

