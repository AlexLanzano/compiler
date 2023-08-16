SRC_URL = https://ftp.gnu.org/gnu/
BINUTILS_VERSION = 2.37
GCC_VERSION = 11.2.0

BUILD_PATH = ${PWD}/build

TARGET ?= arm-none-eabi
PREFIX ?= ${PWD}/$(TARGET)
export PATH := $(PREFIX)/bin:$(PATH)

BINUTILS_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --libdir=$(PREFIX)/$(TARGET)/lib --disable-nls ${ADDITIONAL_BINUTILS_CONFIGURE_OPTIONS}

GCC_BOOTSTRAP_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot=$(PREFIX) --disable-nls --enable-languages=c --without-headers --with-newlib --disable-shared --enable-multilib $(ADDITIONAL_GCC_BOOTSTRAP_CONFIGURE_OPTIONS)

GCC_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot=$(PREFIX) --with-newlib --disable-nls --enable-languages=c,c++ --enable-multilib $(ADDITIONAL_GCC_CONFIGURE_OPTIONS)

NEWLIB_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --disable-newlib-supplied-syscalls $(ADDITIONAL_NEWLIB_CONFIGURE_OPTIONS)

# --disable-newlib-supplied-syscalls --enable-newlib-nano-malloc --enable-newlib-nano-formatted-io --enable-newlib-reent-small --disable-newlib-fvwrite-in-streamio --disable-newlib-fseek-optimization --disable-newlib-wide-orient --enable-newlib-nano-malloc --disable-newlib-unbuf-stream-opt --enable-lite-exit --enable-newlib-global-atexit --enable-newlib-nano-formatted-io --enable-target-optspace

BUILD_TARGETS = binutils gcc-bootstrap newlib gcc clean
