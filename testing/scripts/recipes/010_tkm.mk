#!/usr/bin/make

PKG = tkm
SRC = https://git.codelabs.ch/git/$(PKG).git
REV = 5320ec82f2221d9c4d5be106f6b90287bfb4acce

export ADA_PROJECT_PATH=/usr/local/ada/lib/gnat

all: install

.$(PKG)-cloned:
	[ -d $(PKG) ] || git clone $(SRC) $(PKG)
	@touch $@

.$(PKG)-checkout-$(REV): .$(PKG)-cloned
	cd $(PKG) && git fetch && git checkout $(REV)
	@touch $@

.$(PKG)-built-$(REV): .$(PKG)-checkout-$(REV)
	cd $(PKG) && make
	@touch $@

install: .$(PKG)-built-$(REV)
	cd $(PKG) && make install
