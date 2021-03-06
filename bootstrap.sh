#!/usr/bin/env bash
# deprecated
git pull
function doIt() {
	rsync --exclude ".git/" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
		-av --no-perms . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
