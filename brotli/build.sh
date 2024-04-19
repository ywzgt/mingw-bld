#!/bin/bash
set -e

cmake -B build -S src \
	-DCMAKE_INSTALL_PREFIX=${PREFIX} \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_SYSTEM_NAME=Windows \
	-DCMAKE_C_COMPILER=${TARGET}-cc \
	-DCMAKE_FIND_ROOT_PATH=${PREFIX} \
	-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
	-DCMAKE_FIND_ROOT_PATH_MODE_{LIBRARY,INCLUDE}=ONLY \
	-GNinja -Wno-dev

cmake --build build
cmake --install build
