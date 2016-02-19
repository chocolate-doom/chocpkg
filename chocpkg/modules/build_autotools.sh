
build_autotools::init() {
    PACKAGE_CONFIGURE_OPTS="$@"
}

# This function encapsulates the "./configure; make" process that does the
# actual build of the package. This should work for most autotools-based
# packages but the intention is that this can be overrriden by packages.
do_build() {
    local host_opt=""
    if [ "$PACKAGE_TYPE" = "target" ] && [ "$BUILD_HOST" != "" ]; then
        host_opt="--host=$BUILD_HOST"
    fi

    ./configure --prefix="$PACKAGE_INSTALL_DIR" $host_opt \
                $PACKAGE_CONFIGURE_OPTS || (
        error_exit "Failed to configure package $PACKAGE_NAME for build."
    )

    make $MAKE_OPTS || (
        error_exit "Failed to build package $PACKAGE_NAME."
    )
}

# Function encapsulating the "make install" step which should work for
# most autotools-based packages, but can be overridden by packages.
do_install() {
    make install || (
         error_exit "Failed to install package $PACKAGE_NAME."
    )
}

