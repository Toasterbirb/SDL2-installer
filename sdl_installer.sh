#!/bin/bash
set -e    # Lets not live on the edge

echo "> Checking for dependencies"
which gcc g++ make wget git tar

# Download everything
DL_DIR=./files
mkdir -p $DL_DIR
cd $DL_DIR

echo "> Starting download"

function _downloadAndExtract()
{
	url="$1"
	filename="$2"
	[ -f "./${filename}.tar.gz" ] && rm -r ./$filename || wget "$url"
	tar -xvf ./${filename}.tar.gz
}

# SDL2
_downloadAndExtract "https://www.libsdl.org/release/SDL2-2.0.20.tar.gz" "SDL2-2.0.20"

# SDL2_image
_downloadAndExtract "https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.5.tar.gz" "SDL2_image-2.0.5"

# SDL2_ttf
[ -d ./SDL_ttf ] || git clone https://github.com/libsdl-org/SDL_ttf

# SDL2_mixer
_downloadAndExtract "https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.4.tar.gz" "SDL2_mixer-2.0.4"

# SDL2_gfx
_downloadAndExtract "http://www.ferzkopp.net/Software/SDL2_gfx/SDL2_gfx-1.0.4.tar.gz" "SDL2_gfx-1.0.4"

echo "> Starting compiling..."
files_root="$(pwd)"

# SDL2
cd SDL2-2.0.20
./configure
make -j$(nproc)
make install
cd "$files_root"

# SDL2_image
cd SDL2_image-2.0.5
./configure
make -j$(nproc)
make install
cd "$files_root"

# SDL2_ttf
cd SDL_ttf
./configure
make -j$(nproc)
make install
cd "$files_root"

# SDL_mixer
cd SDL2_mixer-2.0.4
./configure
make -j$(nproc)
make install

# SDL2_gfx
cd SDL2_gfx-1.0.4
./configure
make -j$(nproc)
make install
