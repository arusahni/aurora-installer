#!/bin/bash

# Copyright © 2013 Aru Sahni <arusahni@gmail.com>
# This work is free. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it
# under the terms of the Do What The Fuck You Want To Public License,
# Version 2, as published by Sam Hocevar.
# See the COPYING file for more details.

ROOT_UID=0

if [ $UID != $ROOT_UID ]; then
    echo "This script needs to be run with root priveleges."
    exit 1
fi

FIREFOX_URL=ftp://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-aurora/
FIREFOX_PLATFORM=en-US.linux-x86_64.tar.bz2
INSTALL_DIR=/opt/
SYSFF_BIN_PATH=/usr/bin/firefox
SYSFF_PLUGIN_PATH=/usr/lib/firefox/plugins

function install_firefox ()
{
	echo "Downloading firefox"
	BUNDLE=$(curl --progress-bar -L "$FIREFOX_URL" | grep "$FIREFOX_PLATFORM" | tail -1 | tr -s ' ' | cut -d ' ' -f 9)
	wget -P /tmp/ -N "$FIREFOX_URL""$BUNDLE"
	tar -C /tmp/ -xjf /tmp/"$BUNDLE"
	if [[ -d "$INSTALL_DIR"/firefox ]]; then
		echo "Existing version of firefox detected. Backing up and upgrading."
		rm -rf "$INSTALL_DIR"/firefox-old
		mv "$INSTALL_DIR"/firefox "$INSTALL_DIR"/firefox-old
	fi
	mv /tmp/firefox "$INSTALL_DIR"/firefox
	ln -sf /usr/lib/mozilla/plugins/ "$INSTALL_DIR"/firefox/browser/plugins
    chown -R "$SUDO_USER" "$INSTALL_DIR"/firefox
}

CURRENT_BIN=$(readlink $SYSFF_BIN_PATH)

killall firefox

install_firefox

if [[ "$INSTALL_DIR"firefox/firefox != "$CURRENT_BIN" ]]; then
	if [[ -e "$SYSFF_BIN_PATH" ]]; then
		echo "Renaming the system Firefox to firefox-system"
		mv "$SYSFF_BIN_PATH" "$SYSFF_BIN_PATH"-system
	fi
	ln -s "$INSTALL_DIR"firefox/firefox "$SYSFF_BIN_PATH"
fi

echo "DONE!"
exit
