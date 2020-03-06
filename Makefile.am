ARCHIVE = data/ti-omap3-sgx-bin-1.4.268-armv7hl.tar.bz2
SCRIPT  = data/sbin/powervr
REVISIONS = r121 r125

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = data/pkgconfig/glesv2.pc

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
       $(DESTDIR)$(includedir) \
       $(DESTDIR)$(sysconfdir)/apt/preferences.d \
       $(foreach rev, $(REVISIONS), $(DESTDIR)$(pkglibexecdir)/$(rev)) \
       $(DESTDIR)$(docdir)

$(SCRIPT): %: %.in config.status
	sed 's,@pkglibexecdir@,$(pkglibexecdir),g' $< > $@

$(REVISIONS): files
	install -D -m755 "files/sbin/pvrsrvinit_$@" "$@/pvrsrvinit"
	for lib in $(LIBS); do \
	  install -vD -m644 "files/lib/`basename $$lib .so`_$@.so" $@/$$lib ; \
	done

files: $(ARCHIVE)
	rm -fr files && \
	tar xjf $(ARCHIVE) --strip-components=1 && \
	mv usr files

$(DIRS):
	install -d $@

all: $(REVISIONS) $(SCRIPT)

install: all $(DIRS)
	for rev in $(REVISIONS); do \
	  install -vm644 $$rev/*.so $(DESTDIR)$(pkglibexecdir)/$$rev; \
	  install -vm755 $$rev/pvrsrvinit $(DESTDIR)$(pkglibexecdir)/$$rev; \
	done
	$(LN_S) $(firstword $(REVISIONS)) $(DESTDIR)$(pkglibexecdir)/current
	install -vm755 $(SCRIPT) $(DESTDIR)$(sbindir)
	cp -vr files/include/* $(DESTDIR)$(includedir)
	cp -vr files/share/doc/*/* $(DESTDIR)$(docdir)
	for lib in $(LIBS); do \
	  $(LN_S) $(pkglibexecdir)/current/$$lib $(DESTDIR)$(libdir); \
	done
	$(LN_S) libGLESv2.so  $(DESTDIR)$(libdir)/libGLESv2.so.2
	$(LN_S) libGLES_CM.so $(DESTDIR)$(libdir)/libGLESv1_CM.so.1
	$(LN_S) libEGL.so     $(DESTDIR)$(libdir)/libEGL.so.1
	cp -vr  data/etc/*    $(DESTDIR)$(sysconfdir)
	$(MAKE) install-data

clean-local:
	rm -vrf files $(SCRIPT) $(REVISIONS)
