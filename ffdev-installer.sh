#!/bin/bash

# Copyright © 2015 Aru Sahni <arusahni@gmail.com>
# This work is free. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it
# under the terms of the Do What The Fuck You Want To Public License,
# Version 2, as published by Sam Hocevar.
# See the COPYING file for more details.

# https://github.com/arusahni/ffdev-installer

ROOT_UID=0

if [ $UID != $ROOT_UID ]; then
    echo "This script needs to be run with root priveleges."
    exit 1
fi

FIREFOX_PLATFORM=linux64
FIREFOX_URL="https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=$FIREFOX_PLATFORM&lang=en-US"
INSTALL_DIR=/opt/
SYSFF_BIN_PATH=/usr/local/bin/firefox

function install_firefox ()
{
	echo "Downloading firefox"
    DIRECT_URL=$(wget -S --max-redirect=0 "$FIREFOX_URL" 2>&1 | grep Location | head -1)
    BUNDLE=${DIRECT_URL##*/}
	wget --trust-server -P /tmp/ -N "$FIREFOX_URL"
	tar -C /tmp/ -xjf /tmp/"$BUNDLE"
    killall firefox
	if [[ -d "$INSTALL_DIR"/firefox ]]; then
		echo "Existing version of firefox detected. Backing up and upgrading."
		rm -rf "$INSTALL_DIR"/firefox-old
		mv "$INSTALL_DIR"/firefox "$INSTALL_DIR"/firefox-old
	fi
	mv /tmp/firefox "$INSTALL_DIR"/firefox
	ln -sf /usr/lib/mozilla/plugins/ "$INSTALL_DIR"/firefox/browser/plugins
    chown -R "$SUDO_USER" "$INSTALL_DIR"/firefox
    chown "$SUDO_USER" /tmp/"$BUNDLE" # allow users to delete the installation file if they want
}

CURRENT_BIN=$(readlink $SYSFF_BIN_PATH)

install_firefox

if [[ "$INSTALL_DIR"firefox/firefox != "$CURRENT_BIN" ]]; then
	ln -s "$INSTALL_DIR"firefox/firefox "$SYSFF_BIN_PATH"
fi

echo "DONE!"
exit
