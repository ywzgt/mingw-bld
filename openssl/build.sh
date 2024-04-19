#!/bin/bash
set -e

cd src
CPPFLAGS+=" -I${PREFIX}/include"

if [[ $ARCH = x86_64 ]]; then
	flags=mingw64
else
	flags=mingw
fi

./config --prefix=${PREFIX} \
	--libdir=lib \
	--cross-compile-prefix=${TARGET}- \
	zlib-dynamic \
	enable-brotli-dynamic \
	enable-zstd-dynamic \
	no-docs $flags

make
make install
