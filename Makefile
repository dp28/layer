SHELL := /bin/bash
all: install

install:
	sudo rsync -a bin/layer /usr/local/bin/
	sudo rsync -a lib/ /usr/local/lib/layer --exclude lib/lib
	mkdir ~/.layer
	rsync -a config ~/.layer/
	rsync -a lib/lib ~/.layer/

uninstall:
	sudo rm /usr/local/bin/layer
	sudo rm -r /usr/local/lib/layer
	rm -r ~/.layer

reinstall: uninstall install