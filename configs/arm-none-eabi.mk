SRC_URL = https://ftp.gnu.org/gnu/
BINUTILS_VERSION = 2.37
GCC_VERSION = 11.2.0

BUILD_PATH = ${PWD}/build

TARGET ?= arm-none-eabi
PREFIX ?= ${PWD}/$(TARGET)
export PATH := $(PREFIX)/bin:$(PATH)

BINUTILS_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot --disable-nls ${ADDITIONAL_BINUTILS_CONFIGURE_OPTIONS}

GCC_BOOTSTRAP_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --disable-nls --enable-languages=c,c++ --without-headers

GCC_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot --with-newlib --disable-nls --enable-languages=c,c++ --enable-libstdcxx-pch ${ADDITIONAL_GCC_CONFIGURE_OPTIONS}

NEWLIB_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX}

BUILD_TARGETS = binutils gcc-bootstrap newlib gcc libstdc++ clean
