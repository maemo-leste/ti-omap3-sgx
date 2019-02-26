ARCHIVE = data/ti-omap3-sgx-bin-1.4.268-armv7hl.tar.bz2
SCRIPT  = data/powervr

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = data/glesv2.pc

LIBS = libpvrPVR2D_FLIPWSEGL.so \
       libpvrPVR2D_BLITWSEGL.so \
       libpvrPVR2D_DRI2WSEGL.so \
       libpvrPVR2D_FRONTWSEGL.so \
       libpvrPVR2D_X11WSEGL.so \
       libpvr2d.so \
       libsrv_um.so \
       libPVRScopeServices.so \
       libglslcompiler.so \
       libIMGegl.so \
       libEGL.so \
       libOpenVG.so \
       libOpenVGU.so \
       libGLESv2.so \
       libGLES_CM.so

DIRS = $(DESTDIR)$(libdir) \
       $(DESTDIR)$(sbindir) \
       $(DESTDIR)$(sysconfdir) \
       $(DESTDIR)$(includedir) \
       $(DESTDIR)$(docdir)

REVISIONS = r121 r125
BIN_DIRS := $(foreach rev, $(REVISIONS), $(rev)/sbin)
LIB_DIRS := $(foreach rev, $(REVISIONS), $(rev)/lib)

$(REVISIONS): %: %/lib %/sbin

$(BIN_DIRS): files
	rev=$(@:/sbin=) && \
	install -D -m755 "files/sbin/pvrsrvinit_$$rev" "$@/pvrsrvinit"

$(LIB_DIRS): files
	rev=$(@:/lib=) && \
	for lib in $(LIBS); do \
	  install -vD -m644 "files/lib/`basename $$lib .so`_$$rev.so" $@/$$lib ; \
	done

files: $(ARCHIVE)
	rm -fr files && \
	tar xjf $(ARCHIVE) --strip-components=1 && \
	mv usr files

$(DIRS):
	install -d $@

all: $(SGX)

install: all $(DIRS)
	install -vm644 $(SGX)/lib/*   $(DESTDIR)$(libdir)
	install -vm755 $(SGX)/sbin/*  $(DESTDIR)$(sbindir)
	install -vm755 $(SCRIPT)  $(DESTDIR)$(sbindir)
	cp -vr files/include/*     $(DESTDIR)$(includedir)
	cp -vr files/share/doc/*/* $(DESTDIR)$(docdir)
	$(LN_S) libGLESv2.so  $(DESTDIR)$(libdir)/libGLESv2.so.2
	$(LN_S) libGLES_CM.so $(DESTDIR)$(libdir)/libGLESv1_CM.so.1
	$(LN_S) libEGL.so     $(DESTDIR)$(libdir)/libEGL.so.1
	install -vm644 data/powervr.ini $(DESTDIR)$(sysconfdir)/powervr.ini
	$(MAKE) install-data

clean-local:
	rm -vrf files $(REVISIONS)
