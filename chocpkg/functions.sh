# Recursive function that wraps the main script. Used by some packages to
# conditionally do stuff based on whether other packages are installed.
chocpkg() {
    "$0" "$@"
}

# Determine if a given program is in the PATH.
chocpkg::have_tool() {
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

chocpkg::abort() {
    (echo
     for line in "$@"; do
         echo "$line"
     done) >&2
    exit 1
}

chocpkg::sha256() {
    if chocpkg::have_tool shasum; then
        shasum -a 256 "$@"
    elif chocpkg::have_tool sha256sum; then
        sha256sum "$@"
    else
        chocpkg::abort "No sha256 tool installed."
    fi
}

chocpkg::sha256_digest() {
    chocpkg::sha256 -b "$@" | while read digest rest; do
        echo "$digest"
    done
}

# Works like curl, but will try other tools.
chocpkg::curl() {
    url=$1

    if chocpkg::have_tool curl; then
        curl "$url"
        return
    fi

    if chocpkg::have_tool wget; then
        wget "$url" -O -
        return
    fi

    # Desperate?
    for l in lynx links elinks; do
        if chocpkg::have_tool $l; then
            echo "Using $l to download $url..." >&2
            $l -source "$url"
            return
        fi
    done

    chocpkg::abort "No tool found capable of fetching URLs." \
                   "Please install curl or wget."
}
