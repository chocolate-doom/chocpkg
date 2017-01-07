# Determine if a given program is in the PATH.
have_tool() {
    tool=$1

    result=1
    SAVE_IFS=$IFS
    IFS=:

    for dir in $PATH; do
        if [ -e $dir/$tool ]; then
            #echo $dir/$tool
            result=0
            break
        fi
    done

    IFS=$SAVE_IFS

    return $result
}

error_exit() {
    (echo
     for line in "$@"; do
         echo "$line"
     done) >&2
    exit 1
}

sha256() {
    if have_tool shasum; then
        shasum -a 256 "$@"
    elif have_tool sha256sum; then
        sha256sum "$@"
    else
        error_exit "No sha256 tool installed."
    fi
}

sha256_digest() {
    sha256 -b "$@" | while read digest rest; do
        echo "$digest"
    done
}

# Works like curl, but will try other tools.
cat_url() {
    url=$1

    if have_tool curl; then
        curl "$url"
        return
    fi

    if have_tool wget; then
        wget "$url" -O -
        return
    fi

    # Desperate?
    for l in lynx links elinks; do
        if have_tool $l; then
            echo "Using $l to download $url..." >&2
            $l -source "$url"
            return
        fi
    done

    error_exit "No tool install to fetch URLs. Please install curl or wget."
}
