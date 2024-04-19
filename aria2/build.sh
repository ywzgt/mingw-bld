#!/bin/bash
set -e

cd src
LDFLAGS+=" -static-libgcc"
export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig:${PREFIX}/share/pkgconfig"
if ! ${TARGET}-cc -v 2>&1 | grep -q clang; then
	LDFLAGS+=" -static-libstdc++"
fi

./configure --prefix=${PREFIX} \
	--host=${TARGET} \
	--enable-shared \
	--with-libexpat \
	--with-wintls \
	--with-sqlite3 \
	--without-gnutls \
	--without-libxml2

make
make install
