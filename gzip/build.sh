#!/bin/bash
set -e

cd src
./configure --prefix=${PREFIX} \
	--host=${TARGET}

make
make install
