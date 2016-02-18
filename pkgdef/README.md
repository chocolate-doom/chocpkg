Package files are shell scripts which are expected to set the following
variables to describe how to build the package.

* `PACKAGE_TYPE`: has a value of either `native` or `target`. The
  default is `target`. The variable controls whether the package is
  built for the target system when doing cross-compiles, or whether it
  is part of the build (native) system and just used to build tools as
  part of the build process. The package type determines whether the
  result is installed into `install` or `install.native`.

* `PACKAGE_SOURCE_TYPE`: has a value of either `fetch` or `git`. If the
  value is `fetch`, a tar file is downloaded from the URL in
  `PACKAGE_URL`. If the value is `git`, a git repository is cloned from
  the URL in `GIT_URL`.

* `PACKAGE_VERSION`: version number of the package. If set, this is
  appended to the package name (ie. filename) to make the expected build
  directory name.

* `PACKAGE_URL`: URL to download a tar.gz file from when the `PACKAGE_TYPE`
  is `fetch`.

* `IS_TAR_BOMB`: "Well-formed" .tar files contain a single directory,
  the name of which matches the name of the .tar file. Files which are
  not constructed in this way are called "tar bombs". Setting this
  variable to true indicates that the .tar file found at `PACKAGE_URL`
  is a tar bomb; for safety, the file will be extracted in a directory
  with the expected name.

* `GIT_URL`: URL to `git clone` this package from.

* `GIT_BRANCH`: The Git branch to clone and build from the remote
  repository. Defaults to `master`.

* `PACKAGE_INSTALLED_TOOL`: name of the tool that is built and installed
  by this package. If this variable is set, the tool name is used to
  determine whether the package is installed, by checking `PATH`.

* `PKGCONFIG_NAME`: name of the `pkg-config` .pc file installed by this
  package. If this variable is set, it is used to determine whether the
  package is installed, by invoking `pkg-config`.

* `PACKAGE_CONFIGURE_OPTS`: extra options which will be passed to the
  `configure` script when building the package.

* `DEPENDENCIES`: a list of packages that this package depends upon. When
  building this package, these packages will be recursively built and
  installed automatically if they are not already installed.

### Advanced builds

Complicated packages can require custom build steps. The following functions
can therefore be overridden in the package file in exceptional circumstances:

* `prebuild_setup`: define a function with this name to execute special
  setup commands in the root of a package just before it is built. An
  example is that it is possible to run `autoreconf` to run the autotools
  pipeline and generate expected scripts and outputs.

* `do_build`: the function which is invoked to build the package. The default
  implementation just runs `./configure` followed by `make` (essentially).

* `do_install`: the function which is invoked to install the package. The
  default implementation just runs `make install`.

