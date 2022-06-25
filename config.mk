SRC_URL = https://ftp.gnu.org/gnu/
BINUTILS_VERSION = 2.36.1
GCC_VERSION = 11.1.0

BUILD_PATH = ${PWD}/build

TARGET ?= arm-none-eabi
PREFIX ?= ${PWD}/cross
export PATH := $(PREFIX)/bin:$(PATH)

BINUTILS_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-newlib --with-sysroot=${PREFIX}/${TARGET} --disable-nls

GCC_BOOTSTRAP_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot=${PREFIX}/${TARGET} --without-headers --with-newlib --disable-nls --enable-languages=c,c++ --enable-libstdcxx-pch

GCC_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot=${PREFIX}/${TARGET} --with-newlib --disable-nls --enable-languages=c,c++ --enable-libstdcxx-pch --with-newlib

NEWLIB_CONFIGURE_OPTIONS = --host=x86_64-pc-linux-gnu --target=${TARGET} --prefix=${PREFIX}

MAKE_OPTIONS ?= -j$(shell nproc)
