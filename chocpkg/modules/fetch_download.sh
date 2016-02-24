
fetch_download::init() {
    PACKAGE_URL=$1
    PACKAGE_FILENAME=$(basename "$PACKAGE_URL")
    PACKAGE_DIR_NAME="${PACKAGE_FILENAME/.tar.gz/}"
    IS_TAR_BOMB=false
}

download_package_file() {
    local dlfile="$PACKAGES_DIR/$PACKAGE_FILENAME"
    if [ ! -e "$dlfile" ]; then
        local tmpfile="$dlfile.part"
        if ! chocurl "$PACKAGE_URL" > $tmpfile; then
            error_exit "Failed to download $PACKAGE_URL"
        fi
        mv "$tmpfile" "$dlfile"
    fi
}

extract_package_file() {
    local dlfile="$PACKAGES_DIR/$PACKAGE_FILENAME"
    # Well-formed tar files contain a single directory that matches their
    # filename, but we support an override for badly-formed tar files too,
    # where we extract everything into a directory with the expected name.
    if $IS_TAR_BOMB; then
        mkdir -p "$PACKAGE_BUILD_DIR"
        cd "$PACKAGE_BUILD_DIR"
    else
        cd "$BUILD_DIR"
    fi
    (gunzip < "$dlfile" | tar -x) || (
        mv "$dlfile" "$dlfile.bad"
        error_exit "Failed to extract $PACKAGE_FILENAME: bad download?"
    )
}

do_fetch() {
    download_package_file
    extract_package_file
}

