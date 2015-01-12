build-raspbian-image
====================
Builds a minimal [Raspbian](http://raspbian.org/) image.

Login: `root`
Password: `raspberry`

Only a basic Debian with standard networking utilities.
**Careful: As an exception openssh-server is pre-installed and will allow
root login with the default passwords.**

Dependencies
------------

 * `apt-get install apt-cacher-ng` or change mirror URLs in `bootstrap.sh`
    and `customize.sh`.

 * `apt-get install vmdebootstrap` and install the patch to support the
   raspbian keyring ([Debian bug #770722](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=770722)).

 * `apt-get install binfmt-support qemu-user-static`.

 * `apt-get install ca-certificates curl binutils git-core kmod` (required
   by the rpi-update script).

Usage
-----

Run `./bootstrap.sh` (probably root required for loopback device management)
to create a fresh raspbian-yyyy-mm-dd.img in the current directory.
