include config.mk


all: download unpack configure build install




${BUILD_PATH}/gcc-${GCC_VERSION}.tar.gz:
	wget -P ${BUILD_PATH} ${SRC_URL}/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz

${BUILD_PATH}/binutils-${BINUTILS_VERSION}.tar.gz:
	wget -P ${BUILD_PATH} ${SRC_URL}/binutils/binutils-${BINUTILS_VERSION}.tar.gz 

download-gcc: ${BUILD_PATH}/gcc-${GCC_VERSION}.tar.gz

download-binutils: ${BUILD_PATH}/binutils-${BINUTILS_VERSION}.tar.gz

download: download-gcc download-binutils




${BUILD_PATH}/binutils-${BINUTILS_VERSION}:
	tar -xf $@.tar.gz -C ${BUILD_PATH}

${BUILD_PATH}/gcc-${GCC_VERSION}:
	tar -xf $@.tar.gz -C ${BUILD_PATH}

unpack-gcc: ${BUILD_PATH}/gcc-${GCC_VERSION}

unpack-binutils: ${BUILD_PATH}/binutils-${BINUTILS_VERSION}

unpack: download unpack-gcc unpack-binutils




${BUILD_PATH}/gcc-${GCC_VERSION}/Makefile:
	cd ${BUILD_PATH}/gcc-${GCC_VERSION}/; \
	./contrib/download_prerequisites; \
	./configure ${GCC_CONFIGURE_OPTIONS}

${BUILD_PATH}/binutils-${BINUTILS_VERSION}/Makefile:
	cd ${BUILD_PATH}/binutils-${BINUTILS_VERSION}; \
	./configure ${BINUTILS_CONFIGURE_OPTIONS}

configure-gcc: ${BUILD_PATH}/gcc-${GCC_VERSION}/Makefile

configure-binutils: ${BUILD_PATH}/binutils-${BINUTILS_VERSION}/Makefile

configure: unpack configure-gcc configure-binutils




build-gcc:
	cd ${BUILD_PATH}/gcc-${GCC_VERSION}; \
	make ${MAKE_OPTIONS} all-gcc

build-binutils:
	cd ${BUILD_PATH}/binutils-${BINUTILS_VERSION}; \
	make ${MAKE_OPTIONS}

build: configure build-gcc build-binutils




install-gcc:
	cd ${BUILD_PATH}/gcc-${GCC_VERSION}; \
	make install-gcc

install-binutils:
	cd ${BUILD_PATH}/binutils-${BINUTILS_VERSION}; \
	make install

install: install-gcc install-binutils


clean:
	rm -rf ${BUILD_PATH} ${PREFIX}
