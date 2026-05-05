MAIN_PREFIX = $(DESTDIR)/opt/nd

install:
	mkdir -p $(MAIN_PREFIX) $(APP_PREFIX)
	cp -rf nd packages base base-gui $(MAIN_PREFIX)/

uninstall:
	rm -rf $(MAIN_PREFIX)

.PHONY: install uninstall
