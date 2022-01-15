BINDIR=/usr/local/bin
UNITDIR=/etc/systemd/user
PRESETDIR=/etc/systemd/user-preset
DESTDIR=
PROGNAME=pautosurround

all: $(PROGNAME).service

.PHONY: clean check dist rpm srpm install-unit install-prog install

check:
	mypy --strict $(PROGNAME)

clean:
	find -name '*.pyc' -o -name '*~' -print0 | xargs -0 rm -f
	rm -rf *.tar.gz *.rpm
	rm -rf $(PROGNAME).service

dist: clean
	excludefrom= ; test -f .gitignore && excludefrom=--exclude-from=.gitignore ; DIR=$(PROGNAME)-`awk '/^Version:/ {print $$2}' $(PROGNAME).spec` && FILENAME=$$DIR.tar.gz && tar cvzf "$$FILENAME" --exclude="$$FILENAME" --exclude=.git --exclude=.gitignore $$excludefrom --transform="s|^|$$DIR/|" --show-transformed *

rpm: dist
	T=`mktemp -d` && rpmbuild --define "_topdir $$T" -ta $(PROGNAME)-`awk '/^Version:/ {print $$2}' $(PROGNAME).spec`.tar.gz || { rm -rf "$$T"; exit 1; } && mv "$$T"/RPMS/*/* "$$T"/SRPMS/* . || { rm -rf "$$T"; exit 1; } && rm -rf "$$T"

srpm: dist
	T=`mktemp -d` && rpmbuild --define "_topdir $$T" -ts $(PROGNAME)-`awk '/^Version:/ {print $$2}' $(PROGNAME).spec`.tar.gz || { rm -rf "$$T"; exit 1; } && mv "$$T"/SRPMS/* . || { rm -rf "$$T"; exit 1; } && rm -rf "$$T"

$(PROGNAME).service: $(PROGNAME).service.in
	sed 's|@BINDIR@|$(BINDIR)|g' < $< > $@

$(PROGNAME)-pulse.service: $(PROGNAME).service.in
	sed 's|@BINDIR@|$(BINDIR)|g' < $< > $@

install-prog:
	install -Dm 755 $(PROGNAME) -t $(DESTDIR)/$(BINDIR)/

install-unit: $(PROGNAME).service $(PROGNAME)-pulse.service
	install -Dm 644 $(PROGNAME).service -t $(DESTDIR)/$(UNITDIR)/
	install -Dm 644 $(PROGNAME)-pulse.service -t $(DESTDIR)/$(UNITDIR)/
	install -Dm 644 80-$(PROGNAME).preset -t $(DESTDIR)/$(PRESETDIR)/

install: install-prog install-unit
