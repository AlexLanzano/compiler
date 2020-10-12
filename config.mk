SRC_URL = https://ftp.gnu.org/gnu/
BINUTILS_VERSION = 2.35.1
GCC_VERSION = 10.2.0

BUILD_PATH = ${PWD}/build

TARGET = arm-none-eabi
PREFIX = ${PWD}/cross

BINUTILS_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot --disable-nls 
GCC_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --without-headers --disable-nls --enable-languages=c

MAKE_OPTIONS = -j$(shell nproc)
