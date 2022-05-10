
fetch_git::init() {
    GIT_URL=$1
    if [ $# -gt 1 ]; then
        GIT_BRANCH=$2
    else
        GIT_BRANCH=master
    fi
}

do_fetch() {
    if [ ! -e "$PACKAGE_BUILD_DIR/.git" ]; then
        git clone -b "$GIT_BRANCH" "$GIT_URL" "$PACKAGE_BUILD_DIR"
        return
    fi

    cd "$PACKAGE_BUILD_DIR"
    local current_branch
    if ! current_branch=$(git symbolic-ref --short HEAD) ||
       [[ "$current_branch" != "$GIT_BRANCH" ]]; then
        echo "$PACKAGE_NAME: Switching to '$GIT_BRANCH'..."
        git checkout "$GIT_BRANCH"
        return
    fi

    echo "$PACKAGE_NAME: Fast forwarding branch '$GIT_BRANCH' to latest:"

    # Assume we're tracking an upstream branch, and to be cautious,
    # don't ever perform or commit merges. If a merge needs to be made,
    # let the user resolve the problem themselves.
    git pull --ff-only || chocpkg::abort \
        "Failed to cleanly 'git pull' from upstream. You may need to" \
        "manually resolve merge conflicts with local changes, eg." \
        "" \
        "    cd $PACKAGE_BUILD_DIR" \
        "    git pull"
}

