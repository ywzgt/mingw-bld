#!/bin/bash
set -e

cd src/gettext-runtime

./configure --prefix=${PREFIX} \
	--host=${TARGET}

make
make install
