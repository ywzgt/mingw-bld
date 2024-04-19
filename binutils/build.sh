#!/bin/bash
set -e

cd src
export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig:${PREFIX}/share/pkgconfig"
mkdir build; cd build

../configure --prefix=${PREFIX} \
	--host=${TARGET} \
	--enable-shared \
	--with-system-zlib \
	--disable-gprof \
	--disable-gprofng \
	--disable-libctf \
	--disable-werror \
	acx_cv_cc_gcc_supports_ada=no

make
make tooldir=${PREFIX} install
rm -f ${PREFIX}/lib{bfd,sframe,opcodes}.a
