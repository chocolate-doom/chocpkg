
fetch_download::init() {
    PACKAGE_URL=$1
    PACKAGE_SHA256_DIGEST=$2
    PACKAGE_FILENAME=$(basename "$PACKAGE_URL")
    PACKAGE_DIR_NAME="${PACKAGE_FILENAME/%.tar.*/}"
    IS_TAR_BOMB=false
}

fetch_download::check_sha256_digest() {
    local filename="$1" dldigest
    dldigest=$(chocpkg::sha256_digest "$filename")
    # For development purposes only.
    if [ "$PACKAGE_SHA256_DIGEST" = "ignore-checksum" ]; then
        echo "SHA256 digest of downloaded $PACKAGE_FILENAME:"
        echo "    $dldigest"
        return
    fi
    if [ "$dldigest" != "$PACKAGE_SHA256_DIGEST" ]; then
        chocpkg::abort "sha256 checksum incorrect for $PACKAGE_FILENAME." \
                       "expected: $PACKAGE_SHA256_DIGEST" \
                       "checksum: $dldigest"
    fi
}

fetch_download::download_package_file() {
    local dlfile="$PACKAGES_DIR/$PACKAGE_FILENAME"
    if [ ! -e "$dlfile" ]; then
        local tmpfile="$dlfile.part"
        if ! chocpkg::curl "$PACKAGE_URL" > $tmpfile; then
            chocpkg::abort "Failed to download $PACKAGE_URL"
        fi
        fetch_download::check_sha256_digest "$tmpfile"
        mv "$tmpfile" "$dlfile"
    fi
}

fetch_download::decompress() {
    local filename="$1"
    case "$filename" in
        *.gz)
            gunzip < $filename
            ;;
        *.bz2)
            bunzip2 < $filename
            ;;
        *)
            chocpkg::abort "unknown compression format for filename $filename"
            ;;
    esac
}

fetch_download::extract_package_file() {
    local dlfile="$PACKAGES_DIR/$PACKAGE_FILENAME"
    # Well-formed tar files contain a single directory that matches their
    # filename, but we support an override for badly-formed tar files too,
    # where we extract everything into a directory with the expected name.
    if $IS_TAR_BOMB; then
        mkdir -p "$PACKAGE_BUILD_DIR"
        cd "$PACKAGE_BUILD_DIR"
    else
        local parent_dir=$(dirname "$PACKAGE_BUILD_DIR")
        cd "$parent_dir"
    fi
    (fetch_download::decompress "$dlfile" | tar -x -f -) || (
        mv "$dlfile" "$dlfile.bad"
        chocpkg::abort "Failed to extract $PACKAGE_FILENAME: bad download?"
    )
}

do_fetch() {
    fetch_download::download_package_file
    fetch_download::extract_package_file
}

