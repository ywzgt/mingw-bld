#!/bin/bash
set -e

_flags=(
	IS_MINGW=1
	USE_ASM=1
	IS_X64=1

	CC=${TARGET}-cc
	CXX=${TARGET}-c++
	RC=${TARGET}-windres
)

for i in -lOle32 -lGdi32 -lComctl32 -lComdlg32 -lShell32 \
	-lUser32; do
	sed -i "s/$i/$(echo $i|tr 'A-Z' 'a-z')/g" CPP/7zip/7zip_gcc.mak C/7zip_gcc_c.mak
done

sed -i "/^CFLAGS =/s/-o/$CFLAGS &/g" CPP/7zip/7zip_gcc.mak C/7zip_gcc_c.mak
sed -i "/^CXXFLAGS =/s/-o/$CXXFLAGS &/" CPP/7zip/7zip_gcc.mak
sed -i "s/\(^LDFLAGS = .*\)\r/\1 $LDFLAGS\r/" CPP/7zip/7zip_gcc.mak
sed -i 's/NTSecAPI.h/ntsecapi.h/' CPP/Windows/SecurityUtils.h
sed -i '/^AFLAGS_ABI/s/-DABI_LINUX//;s/-elf64/-win64/;s/-elf/-coff/' C/7zip_gcc_c.mak

if pacman -S uasm --needed --noconfirm 2>/dev/null; then
	ln -s uasm /usr/bin/asmc
else
	curl -LO https://github.com/Terraspace/UASM/files/9881874/uasm256_linux64.zip
	bsdtar xf uasm256_linux64.zip
	install -m755 uasm /usr/bin/asmc
fi

make ${_flags[*]} -C CPP/7zip/Bundles/Format7zF -f makefile.gcc
make ${_flags[*]} -C CPP/7zip/UI/Console -f makefile.gcc
make ${_flags[*]} -C CPP/7zip/Bundles/SFXCon -f makefile.gcc
make ${_flags[*]} -C C/Util/7z -f makefile.gcc

install -Dvt ${PREFIX}/bin -m755 \
	$(find CPP/7zip/Bundles/ -name \*.dll) \
	CPP/7zip/UI/Console/_o/7z.exe \
	CPP/7zip/Bundles/SFXCon/_o/7zCon.exe C/Util/7z/_o/7zdec.exe
