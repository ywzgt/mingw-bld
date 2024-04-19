#!/bin/bash
set -e

cd src
if [[ $ARCH == i686 ]]; then
	flags=mingw32_defconfig
else
	flags=mingw64_defconfig
fi

make $flags
make
install -Dvm755 busybox.exe -t $PREFIX/bin
