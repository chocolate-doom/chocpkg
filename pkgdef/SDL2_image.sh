description "SDL imaging library"
dependencies SDL2
check_pkgconfig SDL2_image
fetch_download https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.1.tar.gz

# SDL2_image supports lots of different file formats but we only care
# about .png files. So just build a really thin library without support
# for all the other formats we don't care about.
# We also disable the OS X ImageIO plugin, and link directly to libpng
# rather than searching for it at runtime.
build_autotools --disable-imageio --disable-png-shared \
    --disable-bmp --disable-gif --disable-jpg --disable-lbm --disable-pcx \
    --disable-pnm --disable-tga --disable-tif --disable-xcf --disable-xpm \
    --disable-xv --disable-webp

