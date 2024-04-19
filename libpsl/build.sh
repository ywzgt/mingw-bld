#!/bin/bash
set -e

meson setup build src \
	--prefix=${PREFIX} \
	--buildtype=release \
	--cross-file=/build/${TARGET}.txt \

ninja -C build
ninja -C build install
