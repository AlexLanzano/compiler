SRC_URL = https://ftp.gnu.org/gnu/
BINUTILS_VERSION = 2.37
GCC_VERSION = 11.2.0

BUILD_PATH = ${PWD}/build

TARGET ?= arm-none-eabi
PREFIX ?= ${PWD}/cross
export PATH := $(PREFIX)/bin:$(PATH)

BINUTILS_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-newlib --with-sysroot=${PREFIX}/${TARGET} --disable-nls ${ADDITIONAL_BINUTILS_CONFIGURE_OPTIONS}

GCC_BOOTSTRAP_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot=${PREFIX}/${TARGET} --without-headers --with-newlib --disable-nls --enable-languages=c,c++ --enable-libstdcxx-pch ${ADDITIONAL_GCC_BOOTSTRAP_CONFIGURE_OPTIONS}

GCC_CONFIGURE_OPTIONS = --target=${TARGET} --prefix=${PREFIX} --with-sysroot=${PREFIX}/${TARGET} --with-newlib --disable-nls --enable-languages=c,c++ --enable-libstdcxx-pch --with-newlib ${ADDITIONAL_GCC_CONFIGURE_OPTIONS}
#--disable-silent-rules --enable-long-long --enable-libstdcxx-pch --disable-install-libiberty --disable-libssp --enable-libitm   --enable-lt  --disable-bootstrap --with-system-zlib --enable-linker-build-id --with-ppl=no --with-cloog=no  --enable-checking=release   --enable-cheaders=c_global  --without-isl  --enable-standard-branch-protection  --enable-poison-system-directories  --enable-nls  --with-glibc-version=2.28  --enable-initfini-array  --without-headers   --with-newlib  --disable-initfini_array --disable-__cxa_atexit  --disable-libstdcxx-pch   --with-newlib   --disable-threads  --enable-plugins  --with-gnu-as  --disable-libitm  --without-long-double-128  --enable-multilib

NEWLIB_CONFIGURE_OPTIONS = --host=x86_64-pc-linux-gnu --target=${TARGET} --prefix=${PREFIX}

MAKE_OPTIONS ?= -j$(shell nproc)
