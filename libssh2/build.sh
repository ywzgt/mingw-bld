#!/bin/bash
set -e

patch -p1 -d src < libssh2-1.11.0-security_fixes-1.patch

cmake -B build -S src \
	-DCMAKE_INSTALL_PREFIX=${PREFIX} \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_SYSTEM_NAME=Windows \
	-DCMAKE_C_COMPILER=${TARGET}-cc \
	-DCMAKE_FIND_ROOT_PATH=${PREFIX} \
	-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
	-DCMAKE_FIND_ROOT_PATH_MODE_{LIBRARY,INCLUDE}=ONLY \
	-DBUILD_{EXAMPLES,TESTING}=OFF \
	-GNinja -Wno-dev

cmake --build build
cmake --install build
