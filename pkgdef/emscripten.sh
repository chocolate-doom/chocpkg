description "Emscripten build environment"

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
     echo ". $PACKAGE_BUILD_DIR/emsdk_env.sh >/dev/null"
     echo "export EMCC_CFLAGS='-s ERROR_ON_MISSING_LIBRARIES=1'"
     echo "exec $emtoolname \"\$@\"") > "$path"
    chmod a+rx "$path"
}

# Emscripten is a weird beast, and wants us to use all its weird tools
# (emconfigure, emmake, etc.). Instead of that, we define a "fake" system
# named wasm32-unknown-emscripten and create wrapper scripts for all the
# necessary compile tools. Then we can build like any other normal
# cross-compile system.
do_install() {
    make_wrapper_script ar     emar
    make_wrapper_script gcc    emcc
    make_wrapper_script g++    em++
    make_wrapper_script ld     emcc
    make_wrapper_script nm     emnm
    make_wrapper_script ranlib emranlib

    echo "Wrapper scripts installed."
}

check_tool wasm32-unknown-emscripten-gcc

