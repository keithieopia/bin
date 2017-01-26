# dotfiles

<img align="right" alt="Markdown Screenshot" src="https://raw.githubusercontent.com/keithieopia/dotfiles/master/.assets/markdown_circle.png">

> *There's no place like $HOME*

These are various config files I use for my Linux environment and related
programs.

**Obligatory Warning:** You should first fork this repository, review the code,
and remove things you don’t want or need. Don't blindly use my settings unless
you know what that entails. Here be dragons!

## High Level Overview
|                   |                                                                       |
| ----------------- | --------------------------------------------------------------------- |
| **shell**:        | [Bash](https://www.gnu.org/software/bash/)                            |
| **terminal**:     | [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html)      |
| **color scheme**: | [Base16 Darktooth](https://github.com/chriskempson/base16-xresources) |
| **editor**:       | [nano](http://www.nano-editor.org/)                                   |
| **font**:         | [Input Mono Compressed](http://input.fontbureau.com/)                 |
| **wm**:           | [bspwm](https://github.com/baskerville/bspwm)                         |
| **compositor**:   | [compton](https://github.com/chjj/compton)                            |
| **media player**: | [mpv](https://mpv.io/)                                                |
| **browser**:      | [Firefox](https://www.mozilla.org/en-US/firefox/new/)                 |

## Directory

* [bash](https://github.com/keithieopia/dotfiles/tree/master/bash):
  .bashrc, aliases, functions, and .bash_profile to start Xorg without a login
  manager.
* [bspwm](https://github.com/keithieopia/dotfiles/blob/master/bspwm/.config/bspwm/bspwmrc):
  window rules and programs to autostart. Includes [hotkeys](https://github.com/keithieopia/dotfiles/blob/master/bspwm/.config/sxhkd/sxhkdrc),
  since [sxhkd hotkeys](https://github.com/baskerville/sxhkd) is basically part
  of bspwm.
* [compton](https://github.com/keithieopia/dotfiles/blob/master/compton/.config/compton.conf):
  shadow and opacity eye candy.
* [default-dirs](https://github.com/keithieopia/dotfiles/blob/master/default-dirs/.config/user-dirs.dirs)
  prevents annoying fluff directories (like ~/Desktop) from being created in
  $HOME. See [XDG user directories](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/)
  for more info.
* [flash](https://github.com/keithieopia/dotfiles/blob/master/flash/.asoundrc):
  Adobe Flash only supports ALSA (not PulseAudio). Even at that it's too
  stupid to detect the correct sound card, resulting in no sound. This is the fix.
* [git](https://github.com/keithieopia/dotfiles/blob/master/git/.gitconfig):
  enable color, set the default GPG key, and allow pushing to non-bare repos.
* [mpv](https://github.com/keithieopia/dotfiles/tree/master/mpv/.config/mpv):
  use hardware acceleration and set the hotkeys. *Am I the only one who thinks
  mpv's defaults keys are annoying?*
* [nano](https://github.com/keithieopia/dotfiles/blob/master/nano/.nanorc):
  clean up the GUI, use spaces for tabs, syntax highlighting, and mouse support.
* [remind](https://github.com/keithieopia/dotfiles/tree/master/remind):
  Personal reminders for [remind](https://www.roaringpenguin.com/products/remind),
  a easy to use console calendar, alarm, and reminder program
* [rxvt](https://github.com/keithieopia/dotfiles/tree/master/rxvt/.config/rxvt):
  cleans up the GUI, sets font and color scheme, and enables clicking on URLs.
* [ssh](https://github.com/keithieopia/dotfiles/blob/master/ssh/.ssh/config):
  use compression, keep alive, add keys to the agent, and some personal server
  aliases.
* [wget](https://github.com/keithieopia/dotfiles/blob/master/wget/.wgetrc):
  saner defaults so you're not waiting forever for failed downloads. Also, spoof
  the user agent
* [xorg](https://github.com/keithieopia/dotfiles/tree/master/xorg):
  Set the xcursor theme, font fixes (anti-aliasing, hinting, etc), and load
  urxvt settings (see [rxvt](https://github.com/keithieopia/dotfiles/tree/master/rxvt/.config/rxvt)
  section)
* [youtube-dl](https://github.com/keithieopia/dotfiles/tree/master/youtube-dl/.config/youtube-dl/config):
  disable IPv6 and anything greater than 720p, because my connection is bad.

### System configs:
Located in the `sys/` folder:

* [bluetooth-headset](https://github.com/keithieopia/dotfiles/tree/master/sys/bluetooth-headset/):
  Settings for BlueZ and PulseAudio so you can use a bluetooth headset. See also
  the [headset](https://github.com/keithieopia/bin/blob/master/headset) script
  in the bin repo.
* [ccache](https://github.com/keithieopia/dotfiles/blob/master/sys/ccache/etc/makepkg.conf):
  speedup recompilation for [makepkg](https://wiki.archlinux.org/index.php/Makepkg)
  by using [ccache](https://ccache.samba.org/) and multiple processor cores
* [chrony](https://github.com/keithieopia/dotfiles/blob/master/sys/chrony/etc/chrony.conf):
  offline-aware and fast NTP clock sync using [chrony](https://chrony.tuxfamily.org/).
* [firefox](https://github.com/keithieopia/dotfiles/tree/master/sys/firefox/usr/lib/firefox):
  disable bloat, tweak for speed, and various other fixes to make Firefox suck
  less.
* [grub](https://github.com/keithieopia/dotfiles/blob/master/sys/grub/):
  use the [Arch-Silence](https://github.com/fghibellini/arch-silence) GRUB2
  theme and setting for a system with full disk encryption.
* [letsencrypt](https://github.com/keithieopia/dotfiles/tree/master/sys/letsencrypt/etc/systemd/system):
  systemD timers for automated [Let's Encrypt](https://letsencrypt.org/)
  renewals using [certbot](https://github.com/certbot/certbot).
* [motd](https://github.com/keithieopia/dotfiles/blob/master/sys/motd/etc/issue):
  a Arch Linux themed MOTD by [davy](https://bbs.archlinux.org/viewtopic.php?id=50845)
* [munin](https://github.com/keithieopia/dotfiles/tree/master/sys/munin/etc):
  settings and systemD timers for [munin](http://munin-monitoring.org/), a
  host and network monitor.
* [mysql](https://github.com/keithieopia/dotfiles/blob/master/sys/mysql/etc/mysql/my.cnf):
  setup [MariaDB](https://mariadb.org/) to use UTF-8 by default
* [nginx](https://github.com/keithieopia/dotfiles/tree/master/sys/nginx/etc):
  setup SSL/HTTPS, PHP, and Munin on [nginx](http://nginx.org/).
* [nobeep](https://github.com/keithieopia/dotfiles/tree/master/sys/nobeep/etc):
  stop annoying PC Speaker beeping.
* [pacman](https://github.com/keithieopia/dotfiles/blob/master/sys/pacman/etc/pacman.conf):
  enable color, multilib, and pacman's pacman (as in the game)
* [quirk-fixes-laptop](https://github.com/keithieopia/dotfiles/tree/master/sys/quirk-fixes-laptop/etc):
  fix slow USB flash drive speed and choppy video/flash performance using Intel's
  driver.
* [quirk-fixes-linode](https://github.com/keithieopia/dotfiles/tree/master/sys/quirk-fixes-linode/etc):
  fix boot errors caused by a custom Arch Linux install; Linode's default image is
  non-standard and very old.
* [samba](https://github.com/keithieopia/dotfiles/tree/master/sys/samba/etc):
  share home directories and mount points. Enable
  [mDNS](https://en.wikipedia.org/wiki/Multicast_DNS) .local hostname
  resolution via [Avahi](https://github.com/lathiat/avahi)
* [sshd](https://github.com/keithieopia/dotfiles/blob/master/sys/sshd/):
  setup ssh with [more secure](https://stribika.github.io/2015/01/04/secure-secure-shell.html)
  settings, set a banner, and use [fail2ban](http://www.fail2ban.org/wiki/index.php/Main_Page)
  to block brute force attacks.
* [unbound](https://github.com/keithieopia/dotfiles/tree/master/sys/unbound/etc):
  run a local cache for DNS with fast resolving by using [named.cache](https://www.internic.net/domain/named.cache) instead of querying
  a DNS server for each domain. Also implement low level ad blocking.


### Unmaintained configs
Located in the `unmaintained` folder:

* [dunst](http://knopwob.org/dunst/):
  a lightweight notification daemon
* [fluidsynth](https://wiki.archlinux.org/index.php/FluidSynth):
  play MIDI audio. Working config for Arch Linux; package points to the wrong
  location for the FluidR3 soundfont
* [vnstat](http://humdi.net/vnstat/)-{laptop,server}:
  basic bandwidth stats and graphing


## Installation / Managing
These dotfiles are managed with [stow](http://www.gnu.org/software/stow/),
which allows you to group dotfiles based on the programs they configure. Thus,
you can pick and choose which dotfiles you want to install.  

For instance, to install all the related bash dotfiles:

```console
$ cd ~  
$ git clone https://github.com/keithieopia/dotfiles.git  
$ cd dotfiles  
$ stow bash
```

Installing any of the system config files in "sys/" with stow is slightly
different, since you need them in / and not $HOME. To install "ssh":

```console
$ cd dotfiles/sys/  
$ sudo stow -t / ssh
```

## Feedback
I would love your feedback! If you found any of these config files useful,
please drop me [an email](mailto:timothykeith@gmail.com). For the privacy
conscious, feel free to encrypt any messages using my [PGP key](http://pgp.mit.edu/pks/lookup?op=vindex&fingerprint=on&search=0xF4F4A135C022EE12):

> 4135 C593 1D89 368E 7F32 C8ED F4F4 A135 C022 EE12

To import it into your keyring:
```console
$  gpg --keyserver pgp.mit.edu --recv-key 4135C5931D89368E7F32C8EDF4F4A135C022EE12
```

Submit bug reports via GitHub's [Issue Tracker](https://github.com/keithieopia/dotfiles/issues)


## Author
Copyright &copy; 2016 - 2017 Timothy Keith

Licensed under the [MIT license](https://github.com/keithieopia/dotfiles/blob/master/LICENSE).

*This is free software: you are free to change and redistribute it. There is NO
WARRANTY, to the extent permitted by law.*
