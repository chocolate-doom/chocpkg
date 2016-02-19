
fetch_git::init() {
    GIT_URL=$1
    if [ $# -gt 1 ]; then
        GIT_BRANCH=$2
    else
        GIT_BRANCH=master
    fi
}

do_fetch() {
    git clone -b "$GIT_BRANCH" "$GIT_URL" "$PACKAGE_BUILD_DIR"
}

