
# The compiler that will be used to build packages for the target system.
# Change this to cross-compile, etc.
CC=gcc
CXX=g++
export CC CXX

# On OS X, we must set additional options: build 32-bit binaries, and the
# target API version.
if [ $(uname) = "Darwin" ]; then
    CC="gcc -m32"
    CXX="g++ -m32"
    LDFLAGS="-lobjc ${LDFLAGS:-}"
    MACOSX_DEPLOYMENT_TARGET=10.7
    export MACOSX_DEPLOYMENT_TARGET
else
    LDFLAGS="-Wl,-rpath -Wl,$INSTALL_DIR/lib ${LDFLAGS:-}"
fi

