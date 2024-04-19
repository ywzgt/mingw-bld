#!/bin/bash
set -e

cd src
export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig:${PREFIX}/share/pkgconfig"

# https://github.com/msys2/MINGW-packages/blob/master/mingw-w64-sqlite3

SQLITE_OPTIONS=(
	-DSQLITE_ENABLE_COLUMN_METADATA=1
	-DSQLITE_USE_MALLOC_H=1
	-DSQLITE_USE_MSIZE=1
	-DSQLITE_DISABLE_DIRSYNC=1
	-DSQLITE_ENABLE_DBSTAT_VTAB=1
	-DSQLITE_SOUNDEX=1
	-DSQLITE_ENABLE_MATH_FUNCTIONS=1
)

CFLAGS+=" -fexceptions -fno-strict-aliasing ${SQLITE_OPTIONS[*]}"

./configure --prefix=${PREFIX} \
	--host=${TARGET} \
	lt_cv_deplibs_check_method=pass_all

make
make install

for tools in ${_sqlite_tools}; do
	install -Dvm755 .libs/$tools ${PREFIX}/bin/$tools
done
