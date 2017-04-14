# dotfiles: unmaintained (system-wide)
These are old, slightly worn and dusty configs. They may not work 
anymore, so use caution.

You may want to visit the main repo [README.md](https://github.com/keithieopia/dotfiles/blob/master/README.md) 
first, if you came here directly from somewhere else.

* [arch-ccache](https://wiki.archlinux.org/index.php/Ccache): speedup 
  recompilation for Arch Linux's [makepkg](https://wiki.archlinux.org/index.php/Makepkg)
* [arch-motd](https://bbs.archlinux.org/viewtopic.php?id=50845): an Arch 
  Linux themed MOTD by user davy
* [arch-pacman](https://wiki.archlinux.org/index.php/Pacman): Arch 
  Linux's package manager. Enables color, multilib, and auto-updates 
  the mirrorlist to the fastest mirrors
* bluetooth-headset: settings for BlueZ and PulseAudio so you can use a 
  bluetooth headset. See also the [headset](https://github.com/keithieopia/bin/blob/master/headset) 
  script in the bin repo
* [chrony](https://chrony.tuxfamily.org/): offline-aware and fast NTP 
  clock sync suitable for laptops
* firefox: disable bloat, tweak for speed, and various other fixes to 
  make Firefox suck less
* [fluidsynth](https://wiki.archlinux.org/index.php/FluidSynth): play 
  MIDI audio. Working config for Arch Linux; package points to the wrong
  location for the FluidR3 soundfont
* lemp: Linux, [nginx](https://nginx.org/), [MariaDB](https://mariadb.org/), 
  and [PHP](http://php.net/) stack. *Note: I still use this, these are 
  settings that I haven't ported yet to my new configs*
* [letsencrypt](https://letsencrypt.org/): free HTTPS (SSL) 
  certificates. These are systemD timers for automated renewals using 
  [certbot](https://github.com/certbot/certbot). *Note: I still use 
  this, I haven't ported any of this yet*
* [munin](http://munin-monitoring.org/): a host and network monitor. 
  This includes client and server settings, as well as systemD timers
* polkit-udiskie: [polkit](https://www.freedesktop.org/wiki/Software/polkit/) 
  rules so [udiskie](https://github.com/coldfix/udiskie) can automount 
  removeable media like CDs and flash drives
* quirks-nobeep: stop annoying PC Speaker beeping
* [samba](https://www.samba.org/): share home directories and mount 
  points with Windows. Also enables [mDNS](https://en.wikipedia.org/wiki/Multicast_DNS) 
  .local hostname resolution via [Avahi](https://github.com/lathiat/avahi)
* sshd: [OpenSSH](http://www.openssh.com/) and [Fail2ban](http://www.fail2ban.org)
  *Note: I still use this, this configs are for Arch Linux; which I 
  don't use anymore*
* [unbound](https://unbound.net/): A local DNS resolver. Uses [named.cache](https://www.internic.net/domain/named.cache) 
  instead of querying a DNS server for each domain. Also implement low 
  level ad blocking
* [vnstat](http://humdi.net/vnstat/)-{laptop,server}: basic bandwidth 
  monitoring, stats, and graphing daemon
