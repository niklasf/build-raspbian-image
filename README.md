build-raspbian-image
====================
Builds a minimal [Raspbian](http://raspbian.org/) Jessie image.

Login: `root`
Password: `raspberry`

Only a basic Debian with standard networking utilities.
**Careful: As an exception openssh-server is pre-installed and will allow
root login with the default password.**

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

Recommended packages
--------------------

 * `ntp` to automatically synchronize the clock over the network. Works without
   any configuration.

 * `iptables` for firewall configuration. Sample `/etc/network/iptables`:

   ```
   *filter
   :INPUT DROP [23:2584]
   :FORWARD ACCEPT [0:0]
   :OUTPUT ACCEPT [1161:105847]
   -A INPUT -i lo -j ACCEPT
   -A INPUT -i eth0 -p tcp -m tcp --dport 22 -j ACCEPT
   -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
   -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
   COMMIT
   ```

   Append `pre-up iptables-restore < /etc/network/iptables` to
   `/etc/network/interfaces`.

 * `fail2ban` to ban IPs trying too many wrong SSH passwords for some time.
   Works without any configuration.

 * `apt-cron` to automatically look for package updates. Regularly updates
   the package lists (but does not install anything) if installed without
   any reconfiguration.

Resize the root partition to the SD card
----------------------------------------

 1. Login. `fdisk /dev/mmcblk0p1`. Delete the partition. Create a new primary
    ext4 parition.

 2. Reboot.

 3. Login. `resize2fs /dev/mmcblk0p1`.
