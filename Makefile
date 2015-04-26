SHELL := /bin/bash
all: install

install:
	echo "sudo password required to install phantomjs and add /usr/local/bin/layer"
	sudo apt-get install phantomjs
	sudo rsync -a bin/layer /usr/local/bin/
	sudo rsync -a lib/ /usr/local/lib/layer --exclude lib/lib
	mkdir ~/.layer
	rsync -a config ~/.layer/
	rsync -a lib/lib ~/.layer/
	echo "Finished installing layer."

uninstall:
	sudo rm /usr/local/bin/layer
	sudo rm -r /usr/local/lib/layer
	rm -r ~/.layer
	echo "Finished uninstalling layer."

reinstall: uninstall install