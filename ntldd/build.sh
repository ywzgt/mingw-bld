#!/bin/bash
set -e

cd src
make CC=${TARGET}-cc AR=${TARGET}-ar
install -Dm755 ntldd.exe ${PREFIX}/bin/ldd.exe
