all:
	@echo "Run make install to install in $(DESTDIR)/"

install:
	mkdir -p $(DESTDIR)/etc $(DESTDIR)/usr
	cp -ra etc/* $(DESTDIR)/etc
	cp -ra usr/* $(DESTDIR)/usr
