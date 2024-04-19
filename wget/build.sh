#!/bin/bash
set -e

cd src
for i in ../*.patch; do
	patch -Np1 -i $i
done

LDFLAGS+=" -L${PREFIX}/lib"
CPPFLAGS+=" -I${PREFIX}/include"

./configure --prefix=${PREFIX} \
	--host=${TARGET} \
	--with-ssl=openssl \
	LIBS="-lbcrypt -lole32"
	#gl_cv_lib_assume_bcrypt=no

make
make install
