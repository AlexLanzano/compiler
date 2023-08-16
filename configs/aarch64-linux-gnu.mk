SRC_URL = https://ftp.gnu.org/gnu/
BINUTILS_VERSION = 2.37
GCC_VERSION = 11.2.0

BUILD_PATH = ${PWD}/build

TARGET ?= aarch64-linux-gnu
PREFIX ?= ${PWD}/$(TARGET)
export PATH := $(PREFIX)/bin:$(PATH)

BINUTILS_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot=${PREFIX}/${TARGET} --disable-nls ${ADDITIONAL_BINUTILS_CONFIGURE_OPTIONS}

GCC_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot=${PREFIX}/${TARGET} --with-newlib --disable-nls --enable-languages=c,c++ --without-headers --with-newlib --disable-shared --disable-decimal-float --disable-threads --disable-libmudflap --disable-libssp --disable-libgomp --disable-quadmath --disable-libatomic --disable-libmpx --disable-libcc1 ${ADDITIONAL_GCC_CONFIGURE_OPTIONS}

MAKE_OPTIONS ?= -j$(shell nproc)

BUILD_TARGETS = binutils gcc-linux clean
