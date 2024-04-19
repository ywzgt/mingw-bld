case "$1" in
	aarch64|armv7|i686|x86_64)
		ARCH=$1; shift
		;;
	*)
		ARCH=x86_64
		;;
esac
PREFIX=/mingw-${ARCH}
TARGET=${ARCH}-w64-mingw32

CFLAGS="-mtune=haswell -O2 -pipe -fPIC -ffunction-sections -fdata-sections"
CXXFLAGS="$CFLAGS -Wp,-D_GLIBCXX_ASSERTIONS"
CPPFLAGS="-DNDEBUG"
LDFLAGS="-Wl,-O2,--gc-sections"
MAKEFLAGS="-j$(nproc)"
NINJA_STATUS="[%r %f/%t %es] "

unset NINJAJOBS
export ARCH PREFIX TARGET
export CFLAGS CXXFLAGS CPPFLAGS LDFLAGS MAKEFLAGS NINJA_STATUS
