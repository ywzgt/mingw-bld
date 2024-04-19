#!/bin/bash
set -e

cd src
LDFLAGS+=" -L${PREFIX}/lib"
CPPFLAGS+=" -I${PREFIX}/include"

./configure --prefix=${PREFIX} \
	--host=${TARGET} \
	--enable-unicode \
	--enable-jit \
	--enable-pcre2-16 \
	--enable-pcre2-32 \
	--enable-pcre2grep-libz \
	--enable-pcre2grep-libbz2

make
make install
