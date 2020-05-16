
build_autotools::init() {
    PACKAGE_CONFIGURE_OPTS="$@"
}

build_autotools::need_autoreconf() {
    if [ -e configure.in ] && [ ! -e configure.ac ]; then
        local configure_ac=configure.in
    else
        local configure_ac=configure.ac
    fi
    # Need to run autoreconf if configure script has not been generated,
    # or if configure.ac has been changed.
    [ ! -e configure ] || [ $configure_ac -nt configure ]
}

# BSD systems usually have their own less-capable version of make, while
# GNU make is installed as `gmake`. If a command named gmake is found,
# prefer that over `make`.
build_autotools::make() {
    if chocpkg::have_tool gmake; then
        gmake "$@"
    else
        make "$@"
    fi
}

# This function encapsulates the "./configure; make" process that does the
# actual build of the package. This should work for most autotools-based
# packages but the intention is that this can be overrriden by packages.
do_build() {
    local host_opt=""
    if [ "$PACKAGE_TYPE" = "target" ] && [ "$BUILD_HOST" != "" ]; then
        host_opt="--host=$BUILD_HOST"
    fi

    # If we're checking out from a version control repository, we may need
    # to run the autotools commands first to generate the configure script.
    if build_autotools::need_autoreconf; then
        if ! chocpkg::have_tool autoreconf; then
            chocpkg::abort "autotools not installed; please run:" \
                           "    chocpkg install native:autotools"
        fi

        autoreconf -fi
    fi

    local configure_path="$PWD/configure"
    if [ ! -z "${AUTOTOOLS_BUILD_PATH:-}" ]; then
        mkdir -p "$AUTOTOOLS_BUILD_PATH"
        cd "$AUTOTOOLS_BUILD_PATH"
    fi

    "$configure_path" --prefix="$PACKAGE_INSTALL_DIR" $host_opt \
                $PACKAGE_CONFIGURE_OPTS || (
        chocpkg::abort "Failed to configure package $PACKAGE_NAME for build."
    )

    build_autotools::make $MAKE_OPTS || (
        chocpkg::abort "Failed to build package $PACKAGE_NAME."
    )
}

# Function encapsulating the "make install" step which should work for
# most autotools-based packages, but can be overridden by packages.
do_install() {
    if [ ! -z "${AUTOTOOLS_BUILD_PATH:-}" ]; then
        cd "$AUTOTOOLS_BUILD_PATH"
    fi

    build_autotools::make install || (
        chocpkg::abort "Failed to install package $PACKAGE_NAME."
    )
}

