SRC_URL = https://ftp.gnu.org/gnu/
BINUTILS_VERSION = 2.36.1
GCC_VERSION = 11.1.0

BUILD_PATH = ${PWD}/build

TARGET = arm-none-eabi
PREFIX = ${PWD}/cross
export PATH := $(PREFIX)/bin:$(PATH)

BINUTILS_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-newlib --with-sysroot=${PREFIX}/arm-none-eabi --disable-nls

GCC_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot=${PREFIX}/arm-none-eabi --with-newlib --disable-nls --without-headers --enable-languages=c,c++ --disable-libstdcxx-pch

NEWLIB_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --disable-libgloss

MAKE_OPTIONS ?= -j$(shell nproc)
