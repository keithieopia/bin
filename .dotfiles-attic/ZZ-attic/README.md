# dotfiles: attic
Previously used configs, scripts, and experiments.

If you came here from somewhere else, you may want to visit the main repo's 
[README.md](https://github.com/keithieopia/dotfiles/blob/master/README.md)  

<img alt="Mad Madam Mim as a Dragon" style="padding-right: 8px" align="left" src="https://raw.githubusercontent.com/keithieopia/dotfiles/master/.readme-assets/mad_madam_min.png">

:warning: **WARNING** :warning:    
*This is old crap. It's more than likely none of this will work anymore.*  
<br>
<br>
  
---  
  
* `arch-linux/`
	* [ccache](https://wiki.archlinux.org/index.php/Ccache): 
	  speedup recompilation for Arch Linux's [makepkg](https://wiki.archlinux.org/index.php/Makepkg)
	* [motd](https://bbs.archlinux.org/viewtopic.php?id=50845): 
	  an Arch Linux themed MOTD by user davy
	* [pacman](https://wiki.archlinux.org/index.php/Pacman): 
	  Arch Linux's package manager. Enables color, multilib, and 
	  auto-updates the mirrorlist to the fastest mirrors
	* polkit-udiskie: 
	  [polkit](https://www.freedesktop.org/wiki/Software/polkit/) 
	  rules so [udiskie](https://github.com/coldfix/udiskie) can auto
	  mount removeable media like CDs and flash drives
	* bluetooth-headset: 
	  settings for BlueZ and PulseAudio so you can use a bluetooth 
	  headset. 
	* sshd: 
	  [OpenSSH](http://www.openssh.com/) and [Fail2ban](http://www.fail2ban.org)
	  *Note: I still use this, this configs are for Arch Linux; which I 
	  don't use anymore*
	* `arch-get-packer`: 
	  Install [packer](https://aur.archlinux.org/packages/packer/), an 
	  [AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers)
	* btw, I *use to* use arch.
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
* `i3/`  
  these configs are actually a fork called i3-gaps, which has greater 
  functionality over vanilla [i3](https://i3wm.org/)
	* `i3blocks/`
		* `bandwidth`: shows the current network speeds
		* `battery`: remaining battery, changes the icon according to charge and if plugged in
		* `colors`: called by the other i3block scripts for "warning", "error", and "success" colors, so the color scheme can be easily changed
		* `cpu`: cumulative cpu utilization across cores. Requires [sysstat](http://sebastien.godard.pagesperso-orange.fr/).
		* `disk`: disk usage
		* `email`: Unread email count for Gmail. Around 15 SLOC, written pure bash, and only depends on `curl`. Other implementations are about 100 SLOC with python/ruby/etc and require add-on libraries
		* `memory`: RAM utilization
		* `volume`: Current volume level, changes icon on mute
    * `lockscreen/`
		* `lockscreen`: 
		  Blurs and locks the screen with *Barney Fife Protection&trade;* that will make evildoers think twice!  
		  Idea based on Jessie Frazelle's [i3lock-fancy](https://github.com/jessfraz/dotfiles/blob/master/bin/fancy-i3lock),
		  which in turn is based on Dolores Portalatin's [i3lock-fancy](https://github.com/meskarune/i3lock-fancy).
		  (License: [MIT](https://opensource.org/licenses/MIT))
	* `lemonade`: 
	  Start a [lemonbar](https://github.com/LemonBoy/bar) panel with useful system info, similar to conky  
	  *Naming convention stolen from Nathan Isom's [dotfiles](https://github.com/neeasade/dotfiles)*
* `jail/`
	* `dropbox`: Nuke dropbox's buggy auto-update mechanism and run it in a firejail sandbox
	* `firefox` - Run Firefox in a firejail sandbox
* lemp: Linux, [nginx](https://nginx.org/), [MariaDB](https://mariadb.org/), 
  and [PHP](http://php.net/) stack. *Note: I still use this, these are 
  settings that I haven't ported yet to my new configs*
* [letsencrypt](https://letsencrypt.org/): free HTTPS (SSL) 
  certificates. These are systemD timers for automated renewals using 
  [certbot](https://github.com/certbot/certbot). *Note: I still use 
  this, I haven't ported any of this yet*
* [quirks-slow-system-with-usb-drives](http://lwn.net/Articles/572911/): 
  fixes freezing found across Linux distros while copying a large amount 
  of date to and from USB drives
* quirks-ubuntu-wifi-killed-on-batt: Ubuntu will turn off the wifi 
  adapter on battery, while using wifi, even when this is disabled in 
  Settings or in NetworkManager. This nukes the adapter's power feature 
  so Ubuntu can't touch it
* [tlp](http://linrunner.de/en/tlp/tlp.html): simple power management 
  for laptops
* [unbound](https://unbound.net/): A local DNS resolver. Uses [named.cache](https://www.internic.net/domain/named.cache) 
  instead of querying a DNS server for each domain. Also implement low 
  level ad blocking
* [vnstat](http://humdi.net/vnstat/)-{laptop,server}: basic bandwidth 
  monitoring, stats, and graphing daemon
* [xorg](https://www.x.org/wiki/): Set the xcursor theme, font fixes 
  (anti-aliasing, hinting, etc), and load rxvt-unicode settings (see 
  rxvt above)
* `battmon`: Will warn about battery levels with increasing severity and then safely shut the system down if the battery gets too low
* `cheese`: Take a picture of yourself using the webcam
* `cryptfox`: Create and launch an encrypted browser profiles
* `headset`: Connect/disconnect a bluetooth headset. Bluetooth in Linux is still crap, so the script repetitively tries to connect before giving up
* `greeting`: Sets the volume to an appropriate level given the time and says a greeting altogether mutes it depending on if it is too late at night
* `local-wiki`: Starts PHP's built-in webserver and Firefox to access a local [dokuwiki](https://www.dokuwiki.org) install. After Firefox is closed, the PHP webserver is automatically stopped.
* `mount-cache`: Create folders and files expected to be in ~/.cache normally, useful if mounted as tmpfs
* `net-wait`: Wait for the network to come up, then start the given app
* `respawn`: Indefinitely restart a program after it exits
* `rxvt`: starts `urxvtd` if it isn't running already. If it is, urxvtc is launched instead
* `say` - Use Pico TTS to speak the given text
* `steam-preload`: Quirks fixes for Steam under bspwm with an Intel graphics card
* `xkcd-pass`: xkcd's [correct horse battery staple](https://xkcd.com/936/) password scheme generator. Uses the kernel's CSPRNG, unlike most implementations
* `xkill`: `kill -9` the current active window. Meant to be invoked by a hotkey
* `zeronet`: Script to run [ZeroNet](https://zeronet.io/), a decentralized censorship resistant network, using [Tor](https://www.torproject.org/) for anonymity, with [Firefox](https://www.mozilla.org/en-US/firefox/new/) [private browsing](https://support.mozilla.org/t5/Protect-your-privacy/Private-Browsing-Use-Firefox-without-saving-history/ta-p/4473).

---

*This is part of my [dotfiles](https://github.com/keithieopia/dotfiles) 
repo. For more information, see the main [README](https://github.com/keithieopia/dotfiles/blob/master/README.md).*
