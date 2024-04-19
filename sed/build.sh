#!/bin/bash
set -e

cd src
./configure --prefix=${PREFIX} \
	--host=${TARGET} LIBS="-lbcrypt"

make
make install
