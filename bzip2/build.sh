#!/bin/bash
set -e

cd src
rm -f README.CYGMING
rm -f aclocal.m4 configure.ac
rm -f libbz2.def.in bzip2.pc.in Makefile.in

sed -i '/AC_INIT/s/1.0.6/1.0.8/;/SO_REV/s/6/8/' ../bzip2-buildsystem.all.patch
for i in ../*.patch; do
	patch -Np1 -i $i
done
autoconf -fiv

./configure --prefix=${PREFIX} \
	--host=${TARGET} \
	--enable-shared

make
make install
