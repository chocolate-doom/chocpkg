
# Check if the specified string matches the glob pattern.
pattern_match() {
    pattern="$1"

    case "$2" in
        $pattern)
            true
            ;;
        *)
            false
            ;;
    esac
}

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

