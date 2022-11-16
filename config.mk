SRC_URL = https://ftp.gnu.org/gnu/
BINUTILS_VERSION = 2.37
GCC_VERSION = 11.2.0

BUILD_PATH = ${PWD}/build

TARGET ?= arm-none-eabi
PREFIX ?= ${PWD}/cross
export PATH := $(PREFIX)/bin:$(PATH)

BINUTILS_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-newlib --with-sysroot=${PREFIX}/${TARGET} --disable-nls ${ADDITIONAL_BINUTILS_CONFIGURE_OPTIONS}

GCC_BOOTSTRAP_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot=${PREFIX}/${TARGET} --without-headers --with-newlib --disable-nls --enable-languages=c,c++ --enable-libstdcxx-pch ${ADDITIONAL_GCC_BOOTSTRAP_CONFIGURE_OPTIONS}

GCC_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot=${PREFIX}/${TARGET} --with-newlib --disable-nls --enable-languages=c,c++ --enable-libstdcxx-pch ${ADDITIONAL_GCC_CONFIGURE_OPTIONS}

NEWLIB_CONFIGURE_OPTIONS = --host=x86_64-pc-linux-gnu --target=${TARGET} --prefix=${PREFIX}

MAKE_OPTIONS ?= -j$(shell nproc)
