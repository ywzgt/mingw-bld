#!/bin/bash
set -e

grep -rl curl-ca-bundle.crt | xargs sed -i 's/curl-ca-bundle.crt/cert.pem/g'

_http3() {
	if [[ -f ${PREFIX}/include/ngtcp2_crypto_quictls.h ]]; then
		echo -DUSE_NGTCP2=ON
	else
		echo -DUSE_OPENSSL_QUIC=ON
	fi
}

cmake -B build -S src \
	-DCMAKE_INSTALL_PREFIX=${PREFIX} \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_SYSTEM_NAME=Windows \
	-DCMAKE_C_COMPILER=${TARGET}-cc \
	-DCMAKE_FIND_ROOT_PATH=${PREFIX} \
	-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
	-DCMAKE_FIND_ROOT_PATH_MODE_{LIBRARY,INCLUDE}=ONLY \
	-DCURL_USE_OPENSSL=ON -DENABLE_UNICODE=ON \
	-DCURL_CA_BUNDLE=C:/Windows/ssl/cert.pem \
	-DCURL_{BROTLI,ZSTD}=ON \
	-DUSE_NGHTTP2=ON $(_http3) \
	-GNinja -Wno-dev

cmake --build build
cmake --install build
