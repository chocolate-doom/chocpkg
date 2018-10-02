description "Emscripten build environment"
fetch_git https://github.com/juj/emsdk.git

do_build() {
    ./emsdk install latest
    ./emsdk activate latest
}

make_wrapper_script() {
    local toolname emtoolname path
    toolname="$1"
    emtoolname="$2"
    path="$PACKAGE_INSTALL_DIR/bin/asmjs-local-emscripten-$toolname"
    mkdir -p "$PACKAGE_INSTALL_DIR/bin"
    (echo "#!/bin/bash"
     echo ". $PACKAGE_BUILD_DIR/emsdk_env.sh >/dev/null"
     echo "export EMCC_CFLAGS='-s ERROR_ON_MISSING_LIBRARIES=1'"
     echo "exec $emtoolname \"\$@\"") > "$path"
    chmod a+rx "$path"
}

# Emscripten is a weird beast, and wants us to use all its weird tools
# (emconfigure, emmake, etc.). Instead of that, we define a "fake" system
# named asmjs-local-emscripten and create wrapper scripts for all the
# necessary compile tools. Then we can build like any other normal
# cross-compile system.
do_install() {
    make_wrapper_script ar     emar
    make_wrapper_script gcc    emcc
    make_wrapper_script g++    em++
    make_wrapper_script ld     emcc
    make_wrapper_script nm     llvm-nm
    make_wrapper_script ranlib emranlib
}

check_tool asmjs-local-emscripten-gcc

