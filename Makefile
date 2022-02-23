include config.mk


all: download unpack binutils gcc newlib libstdc++

binutils: configure-binutils build-binutils install-binutils
gcc: configure-gcc build-gcc install-gcc
newlib: configure-newlib build-newlib install-newlib
libstdc++: build-libstdc++ install-libstdc++




$(BUILD_PATH)/gcc-$(GCC_VERSION).tar.gz:
	wget -P $(BUILD_PATH) $(SRC_URL)/gcc/gcc-$(GCC_VERSION)/gcc-$(GCC_VERSION).tar.gz

$(BUILD_PATH)/binutils-$(BINUTILS_VERSION).tar.gz:
	wget -P $(BUILD_PATH) $(SRC_URL)/binutils/binutils-$(BINUTILS_VERSION).tar.gz

$(BUILD_PATH)/newlib-cygwin:
	git clone git://sourceware.org/git/newlib-cygwin.git $(BUILD_PATH)/newlib-cygwin

download-gcc: $(BUILD_PATH)/gcc-$(GCC_VERSION).tar.gz

download-binutils: $(BUILD_PATH)/binutils-$(BINUTILS_VERSION).tar.gz

download-newlib: $(BUILD_PATH)/newlib-cygwin

download: download-gcc download-binutils download-newlib




$(BUILD_PATH)/binutils-$(BINUTILS_VERSION):
	tar -xf $@.tar.gz -C $(BUILD_PATH)

$(BUILD_PATH)/gcc-$(GCC_VERSION):
	tar -xf $@.tar.gz -C $(BUILD_PATH)
	cd $@; \
	./contrib/download_prerequisites

unpack-gcc: $(BUILD_PATH)/gcc-$(GCC_VERSION)

unpack-binutils: $(BUILD_PATH)/binutils-$(BINUTILS_VERSION)

unpack: download unpack-gcc unpack-binutils




$(BUILD_PATH)/gcc-$(GCC_VERSION)/Makefile:
	mkdir $(BUILD_PATH)/gcc-build
	cd $(BUILD_PATH)/gcc-build; \
	../gcc-$(GCC_VERSION)/configure $(GCC_CONFIGURE_OPTIONS)

$(BUILD_PATH)/binutils-$(BINUTILS_VERSION)/Makefile:
	mkdir $(BUILD_PATH)/binutils-build
	cd $(BUILD_PATH)/binutils-build; \
	../binutils-$(BINUTILS_VERSION)/configure $(BINUTILS_CONFIGURE_OPTIONS)

$(BUILD_PATH)/newlib-build/Makefile:
	mkdir $(BUILD_PATH)/newlib-build
	cd $(BUILD_PATH)/newlib-build; \
	../newlib-cygwin/configure $(NEWLIB_CONFIGURE_OPTIONS)

configure-gcc: $(BUILD_PATH)/gcc-$(GCC_VERSION)/Makefile

configure-binutils: $(BUILD_PATH)/binutils-$(BINUTILS_VERSION)/Makefile

configure-newlib: $(BUILD_PATH)/newlib-build/Makefile




build-gcc:
	cd $(BUILD_PATH)/gcc-build; \
	make $(MAKE_OPTIONS) all-gcc; \
	make $(MAKE_OPTIONS) all-target-libgcc

build-libstdc++:
	cd $(BUILD_PATH)/gcc-build; \
	make $(MAKE_OPTIONS) all-target-libstdc++-v3

build-binutils:
	$(MAKE) $(MAKE_OPTIONS) -C $(BUILD_PATH)/binutils-build

build-newlib:
	cd $(BUILD_PATH)/newlib-build; \
	make $(MAKE_OPTIONS)




install-gcc:
	cd $(BUILD_PATH)/gcc-build; \
	make install-gcc; \
	make install-target-libgcc

install-libstdc++:
	cd $(BUILD_PATH)/gcc-build; \
	make install-target-libstdc++-v3

install-binutils:
	$(MAKE) -C $(BUILD_PATH)/binutils-build install

install-newlib:
	cd $(BUILD_PATH)/newlib-build; \
	make install




clean:
	rm -rf $(BUILD_PATH) $(PREFIX)
