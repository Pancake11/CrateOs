#!/bin/bash

curl -wget https://ftp.gnu.org/gnu/gcc/gcc-8.3.0/gcc-8.3.0.tar.gz -o gcc-8.3.0.tar.gz
curl -wget https://ftp.gnu.org/gnu/binutils/binutils-2.32.tar.gz -o binutils-2.32.tar.gz

tar -xvzf binutils-2.32.tar.gz
tar -xvzf gcc-8.3.0.tar.gz

export PREFIX=$(pwd)
export TARGET=i686-elf
 
mkdir build-binutils
cd build-binutils
../binutils-2.32/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install

cd ..
 
# The $PREFIX/bin dir _must_ be in the PATH. We did that above.
which -- $TARGET-as || echo $TARGET-as is not in the PATH
 
mkdir build-gcc
cd build-gcc
../gcc-8.3.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc
