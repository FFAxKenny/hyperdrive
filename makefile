# Makefile!
# TODO: Add command to create binary symlinks
all:

install:
	@echo "Installing.."
	mkdir -p /usr/local/hyperdrive
	cp -R src/ /usr/local/hyperdrive/
	ln -fs /usr/local/hyperdrive/src/hyperdrive.py /usr/local/bin/hyperdrive
