#!/bin/bash
set -e

cmake -B build -S src \
	-DCMAKE_INSTALL_PREFIX=${PREFIX} \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_SYSTEM_NAME=Windows \
	-DCMAKE_C_COMPILER=${TARGET}-cc \
	-DCMAKE_CXX_COMPILER=${TARGET}-c++ \
	-DCMAKE_FIND_ROOT_PATH=${PREFIX} \
	-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
	-DCMAKE_FIND_ROOT_PATH_MODE_{LIBRARY,INCLUDE}=ONLY \
	-DBUILD_SHARED_LIBS=ON \
	-GNinja -Wno-dev

cmake --build build
cmake --install build

if [[ -f ${PREFIX}/lib/libliblzma.dll.a && ! -e ${PREFIX}/lib/liblzma.dll.a ]]; then
	ln -s libliblzma.dll.a ${PREFIX}/lib/liblzma.dll.a
fi
