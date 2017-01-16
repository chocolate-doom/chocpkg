
# Value passed to ./configure for the --host argument. If empty, then
# --host will not be passed. Set this if you want to cross-compile.
BUILD_HOST=

# An example of how to cross-compile to mingw32 for Windows builds:
#BUILD_HOST=i686-w64-mingw32

# If we're cross-compiling to a different platform, this should be set
# to true. We initialize this based on whether BUILD_HOST has been set.
if [ "$BUILD_HOST" != "" ]; then
  IS_CROSS_COMPILE=true
else
  IS_CROSS_COMPILE=false
fi

# Extra arguments we pass to make when building.
MAKE_OPTS=

# Uncomment to use more threads for faster builds.
#MAKE_OPTS=-j4

# By default the stable variant of packages is built unless otherwise
# requested. If a package name appears inside this array, the "latest"
# variant of that package (ie. source control HEAD) is built instead.
LATEST_PACKAGES=(chocolate-doom)
#LATEST_PACKAGES+=(SDL2 SDL2_image SDL2_mixer SDL2_net)

if [ $(uname) = "Darwin" ]; then
    LDFLAGS="-lobjc ${LDFLAGS:-}"
    MACOSX_DEPLOYMENT_TARGET=10.7
    export LDFLAGS MACOSX_DEPLOYMENT_TARGET
elif [[ "$BUILD_HOST" =~ mingw ]]; then
    # MingW builds need the -static-libgcc option, otherwise we
    # will depend on an unnecessary DLL, libgcc_s_sjlj-1.dll. Note that
    # this specifically needs to be done via the CC environment variable
    # rather than CFLAGS/LDFLAGS, otherwise libtool strips it out.
    CC="${BUILD_HOST}-gcc -static-libgcc"
    export CC
else
    # Include $INSTALL_DIR/lib in the list of paths that is searched
    # when looking for DLLs. This allows built binaries to be run
    # without needing to set LD_LIBRARY_PATH every time.
    LDFLAGS="-Wl,-rpath -Wl,$INSTALL_DIR/lib ${LDFLAGS:-}"
    export LDFLAGS
fi

