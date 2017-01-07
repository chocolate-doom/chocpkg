
build_python::init() {
    PACKAGE_CONFIGURE_OPTS="$@"
}

do_build() {
    # TODO: Build specifying correct target type.
    python setup.py build || (
        chocpkg::abort "Failed to build package $PACKAGE_NAME."
    )
}

do_install() {
    # Instead of the usual site-packages install directory, we use
    # our own directory for chocpkg python package installs. The
    # PYTHONPATH environment variable will be set as appropriate in
    # order to find these directories.
    # The reason for doing things this way is that the site-packages
    # paths include the Python version number, making the path hard
    # to construct.
    local python_lib_path="$PACKAGE_INSTALL_DIR/lib/chocpkg-python"

    python setup.py install "--install-purelib=$python_lib_path" \
                            "--prefix=$PACKAGE_INSTALL_DIR" || (
        chocpkg::abort "Failed to install package $PACKAGE_NAME."
    )
}

