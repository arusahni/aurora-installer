Aurora Installer
================

This script installs and upgrades 64-bit Firefox Aurora on Ubuntu Linux systems using Mozilla's binaries

Why?
----
The Aurora PPA is always slow to publish whenever a new 6-week cycle of Aurora development kicks off.  That, in addition to the fact that Canonical's Firefox builds always misbehave, made me put this script together.

What does it do?
----------------
This:

1. Closes all open instances of Firefox
2. Downloads the most recent x64 Aurora build
3. Installs it to /opt/firefox (creating a backup at /opt/firefox-old just in case something's wrong with that day's build)
4. Links the new instance of Firefox to the system Firefox's plugin directory.
5. Renames your system Firefox to `firefox-system` and takes over the `firefox` command.

You should be able to run this repeatedly without issue. If you encounter any bugs, feel free to file a report or a PR!

LICENSE
=======
Copyright © 2013 Aru Sahni &lt;arusahni@gmail.com&gt;

This work is free. It comes without any warranty, to the extent 
permitted by applicable law. You can redistribute it and/or modify it
under the terms of the Do What The Fuck You Want To Public License,
Version 2, as published by Sam Hocevar.

See the COPYING file for more details.

![Analytics](https://ga-beacon.appspot.com/UA-46766795-1/aurora-installer/README?pixel)
