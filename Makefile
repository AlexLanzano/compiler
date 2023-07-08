
check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Please define $1$(if $2, ($2))))

MAKE_OPTIONS = -j$(shell nproc)

patch = $(shell for i in $1/*.patch; do patch -d $2 -t -p1 < $i; done )

$(call check_defined, CONFIG)

include $(CONFIG)

$(call check_defined, TARGET, cross compiler target architecture)

$(call check_defined, PREFIX, Directory where the compiler will be installed)

all: download unpack patch $(BUILD_TARGETS)

#all: download unpack patch binutils gcc-bootstrap newlib gcc libstdc++ clean
#all-without-newlib: download unpack patch binutils gcc clean
#all-linux: download unpack patch binutils gcc-linux clean

binutils: configure-binutils build-binutils install-binutils
gcc-bootstrap: configure-gcc-bootstrap build-gcc-bootstrap install-gcc-bootstrap
newlib: configure-newlib build-newlib install-newlib
gcc: configure-gcc build-gcc install-gcc
gcc-linux: configure-gcc build-gcc-linux install-gcc-linux
libstdc++: build-libstdc++ install-libstdc++




$(BUILD_PATH)/gcc-$(GCC_VERSION).tar.gz:
	wget --no-check-certificate -P $(BUILD_PATH) $(SRC_URL)/gcc/gcc-$(GCC_VERSION)/gcc-$(GCC_VERSION).tar.gz

$(BUILD_PATH)/binutils-$(BINUTILS_VERSION).tar.gz:
	wget --no-check-certificate -P $(BUILD_PATH) $(SRC_URL)/binutils/binutils-$(BINUTILS_VERSION).tar.gz

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




patch: unpack patch-binutils patch-gcc

ifdef GCC_PATCH_FILE_PATH
patch-gcc: $(BUILD_PATH)/gcc-$(GCC_VERSION)/patched
else
patch-gcc:
endif

ifdef BINUTILS_PATCH_FILE_PATH
patch-binutils: $(BUILD_PATH)/binutils-$(BINUTILS_VERSION)/patched
else
patch-binutils:
endif

$(BUILD_PATH)/gcc-$(GCC_VERSION)/patched:
	./patch.sh $(GCC_PATCH_FILE_PATH) $(BUILD_PATH)/gcc-$(GCC_VERSION)
	touch $@

$(BUILD_PATH)/binutils-$(BINUTILS_VERSION)/patched: $(BUILD_PATH)/binutils-$(BINUTILS_VERSION)/patched
	./patch.sh $(BINUTILS_PATCH_FILE_PATH) $(BUILD_PATH)/binutils-$(BINUTILS_VERSION)
	touch $@




$(BUILD_PATH)/gcc-build/Makefile:
	mkdir $(BUILD_PATH)/gcc-build
	cd $(BUILD_PATH)/gcc-build; \
	../gcc-$(GCC_VERSION)/configure $(GCC_BOOTSTRAP_CONFIGURE_OPTIONS)

$(BUILD_PATH)/binutils-build/Makefile:
	mkdir $(BUILD_PATH)/binutils-build
	cd $(BUILD_PATH)/binutils-build; \
	../binutils-$(BINUTILS_VERSION)/configure $(BINUTILS_CONFIGURE_OPTIONS)

$(BUILD_PATH)/newlib-build/Makefile:
	mkdir $(BUILD_PATH)/newlib-build
	cd $(BUILD_PATH)/newlib-build; \
	../newlib-cygwin/configure $(NEWLIB_CONFIGURE_OPTIONS)

configure-gcc-bootstrap: $(BUILD_PATH)/gcc-build/Makefile

configure-gcc:
	mkdir -p $(BUILD_PATH)/gcc-build
	cd $(BUILD_PATH)/gcc-build; \
	../gcc-$(GCC_VERSION)/configure $(GCC_CONFIGURE_OPTIONS)

configure-binutils: $(BUILD_PATH)/binutils-build/Makefile

configure-newlib: $(BUILD_PATH)/newlib-build/Makefile



build-gcc-bootstrap:
	cd $(BUILD_PATH)/gcc-build; \
	make $(MAKE_OPTIONS) all-gcc; \
	make $(MAKE_OPTIONS) all-target-libgcc

build-gcc:
	cd $(BUILD_PATH)/gcc-build; \
	make $(MAKE_OPTIONS) all-gcc; \
	make $(MAKE_OPTIONS) all-target-libgcc; \
	make $(MAKE_OPTIONS) all-target-newlib; \
	make $(MAKE_OPTIONS) all-target-libgloss

build-gcc-linux:
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




install-gcc-bootstrap:
	cd $(BUILD_PATH)/gcc-build; \
	make install-gcc; \
	make install-target-libgcc

install-gcc:
	cd $(BUILD_PATH)/gcc-build; \
	make install-gcc; \
	make install-target-libgcc; \
	make install-target-newlib; \
	make install-target-libgloss

install-gcc-linux:
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
	rm -rf $(BUILD_PATH)
