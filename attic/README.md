# dotfiles: attic
These are old, slightly worn and dusty configs. They may not work 
anymore, so use caution.

You may want to visit the main repo [README.md](https://github.com/keithieopia/dotfiles/blob/master/README.md) 
first, if you came here directly from somewhere else.

* arch-linux/[ccache](https://wiki.archlinux.org/index.php/Ccache): speedup 
  recompilation for Arch Linux's [makepkg](https://wiki.archlinux.org/index.php/Makepkg)
* arch-linux/[motd](https://bbs.archlinux.org/viewtopic.php?id=50845): an Arch 
  Linux themed MOTD by user davy
* arch-linux/[pacman](https://wiki.archlinux.org/index.php/Pacman): Arch 
  Linux's package manager. Enables color, multilib, and auto-updates 
  the mirrorlist to the fastest mirrors
* arch-linux/polkit-udiskie: [polkit](https://www.freedesktop.org/wiki/Software/polkit/) 
  rules so [udiskie](https://github.com/coldfix/udiskie) can automount 
  removeable media like CDs and flash drives
* arch-linux/bluetooth-headset: settings for BlueZ and PulseAudio so you can use a 
  bluetooth headset. See also the [headset](https://github.com/keithieopia/bin/blob/master/headset) 
  script in the bin repo
* arch-linux/sshd: [OpenSSH](http://www.openssh.com/) and [Fail2ban](http://www.fail2ban.org)
  *Note: I still use this, this configs are for Arch Linux; which I 
  don't use anymore*
* [bspwm](https://github.com/baskerville/bspwm):
  window manager and [sxhkd](https://github.com/baskerville/sxhkd) 
  which manages hotkeys and is more or less mandatory to make bspwm
  functional
* [chrony](https://chrony.tuxfamily.org/): offline-aware and fast NTP 
  clock sync suitable for laptops
* [compton](https://github.com/chjj/compton): compositor for shadow and 
  opacity eye candy
* [dunst](http://knopwob.org/dunst/): a lightweight notification daemon
* firefox: disable bloat, tweak for speed, and various other fixes to 
  make Firefox suck less
* [fluidsynth](https://wiki.archlinux.org/index.php/FluidSynth): play 
  MIDI audio. Working config for Arch Linux; package points to the wrong
  location for the FluidR3 soundfont
* [i3](https://github.com/Airblader/i3): a window manager, these configs 
  are actually a fork called i3-gaps, which has greater functionality 
  over vanilla [i3](https://i3wm.org/)
* lemp: Linux, [nginx](https://nginx.org/), [MariaDB](https://mariadb.org/), 
  and [PHP](http://php.net/) stack. *Note: I still use this, these are 
  settings that I haven't ported yet to my new configs*
* [letsencrypt](https://letsencrypt.org/): free HTTPS (SSL) 
  certificates. These are systemD timers for automated renewals using 
  [certbot](https://github.com/certbot/certbot). *Note: I still use 
  this, I haven't ported any of this yet*
* [munin](http://munin-monitoring.org/): a host and network monitor. 
  This includes client and server settings, as well as systemD timers
* quirks-adobe-flash: Adobe Flash's NPAPI plugin (e.g.: for Firefox) 
  only supports ALSA and not PulseAudio. Even at that, the plugin is too
  stupid to detect the correct sound card, resulting in no sound. This 
  is the `~/.asoundrc` fix
* quirks-nobeep: stop annoying PC Speaker beeping
* [quirks-slow-system-with-usb-drives](http://lwn.net/Articles/572911/): 
  fixes freezing found across Linux distros while copying a large amount 
  of date to and from USB drives
* quirks-ubuntu-wifi-killed-on-batt: Ubuntu will turn off the wifi 
  adapter on battery, while using wifi, even when this is disabled in 
  Settings or in NetworkManager. This nukes the adapter's power feature 
  so Ubuntu can't touch it
* [remind](https://www.roaringpenguin.com/products/remind): a easy to 
  use console calendar, alarm, and reminder program
* [rxvt](http://software.schmorp.de/pkg/rxvt-unicode.html): a terminal 
  emulator, configs are actually for the rxvt-unicode fork which sets 
  the font and color scheme, cleans up the GUI, and enables clicking on 
  URLs
* [samba](https://www.samba.org/): share home directories and mount 
  points with Windows. Also enables [mDNS](https://en.wikipedia.org/wiki/Multicast_DNS) 
  .local hostname resolution via [Avahi](https://github.com/lathiat/avahi)
* [unbound](https://unbound.net/): A local DNS resolver. Uses [named.cache](https://www.internic.net/domain/named.cache) 
  instead of querying a DNS server for each domain. Also implement low 
  level ad blocking
* [vnstat](http://humdi.net/vnstat/)-{laptop,server}: basic bandwidth 
  monitoring, stats, and graphing daemon
* [xorg](https://www.x.org/wiki/): Set the xcursor theme, font fixes 
  (anti-aliasing, hinting, etc), and load rxvt-unicode settings (see 
  rxvt above)
