
CHOCPKG_ROOT=$HOME/chocolate-doom-build
export CHOCPKG_ROOT

# Build directory must not contain a space, or bad things happen:
case "$CHOCPKG_ROOT" in
*\ *)
cat <<END
The path to your home directory contains a space:

    HOME=$HOME

This script will probably fail to build - reset HOME to point
somewhere else. For example, type:

    mkdir /home/user
    HOME=/home/user
END
exit -1
esac

# Set up various environment variables:
PATH="$CHOCPKG_ROOT/chocpkg:$CHOCPKG_ROOT/install.native/bin:$PATH"

