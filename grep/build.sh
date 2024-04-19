#!/bin/bash
set -e

cd src
LDFLAGS+=" -L${PREFIX}/lib"
CPPFLAGS+=" -I${PREFIX}/include"

./configure --prefix=${PREFIX} \
	--host=${TARGET}

make
make install
