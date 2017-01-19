# dotfiles

<img align="right" alt="Markdown Screenshot" src="https://raw.githubusercontent.com/keithieopia/dotfiles/master/.assets/markdown_circle.png">

> *There's no place like $HOME*

These are various config files I use for my Linux environment and related
programs.

**Obligatory Warning:** You should first fork this repository, review the code,
and remove things you don’t want or need. Don't blindly use my settings unless
you know what that entails. Here be dragons!

## What programs do these configure?
 * [bash](https://www.gnu.org/software/bash/): .bashrc, a ton of aliases, and
   startx without a login manager
 * [bspwm](https://github.com/baskerville/bspwm): tiling window manager with
   [sxhkd](https://github.com/baskerville/sxhkd) hotkey daemon, autostarts many
   scripts found in the [bin](https://github.com/keithieopia/bin) repo
 * [compton](https://github.com/chjj/compton): composite manager for
   transparency and shadows
 * [default-dirs](https://wiki.archlinux.org/index.php/XDG_user_directories):
   prevent annoying directories being auto created in $HOME
 * [git](https://git-scm.com/docs/git-config): git VCS default settings; mostly
   sign commits with GPG and enable colors
 * [nano](http://www.nano-editor.org/): disregard Cult of vi and Church of
   Emacs, your fingers will thank you
 * [remind](https://www.roaringpenguin.com/products/remind): easy to use console
   calendar, alarm, and reminder program
 * [rxvt](http://software.schmorp.de/pkg/rxvt-unicode.html): transparency,
   [iosevka](https://be5invis.github.io/Iosevka/) font, and
   [raven-dark](https://github.com/baskerville/xresources-color-schemes) color
   scheme
 * [ssh](http://www.openssh.com/): some good defaults for usability and host
   aliases
 * [wget](https://www.gnu.org/software/wget/): saner defaults so you're not
   waiting forever for failed downloads
 * [xorg](http://www.x.org/wiki/): set minor Xorg settings and launch the WM

### System configs:
Located in the `sys/` folder:

 * bluetooth-headset: Settings for BlueZ and PulseAudio so you can use a
   bluetooth headset
 * [ccache](https://wiki.archlinux.org/index.php/Ccache): speedup tricks for
   [makepkg](https://wiki.archlinux.org/index.php/Makepkg) using ccache and
   multiple processor cores
 * [chrony](https://chrony.tuxfamily.org/): Offline-aware NTP clock sync
 * [fail2ban](http://www.fail2ban.org/wiki/index.php/Main_Page): Prevent brute
   force attacks against a variety of services
 * [grub](https://www.gnu.org/software/grub/): nice Arch Linux theme for the
   GRUB bootloader with password protection
 * [letsencrypt](https://letsencrypt.org/): free CA for providing HTTPS. This
   uses a systemd timer for automated renewals using
   [certbot](https://github.com/certbot/certbot)
 * motd-arch: A MOTD for Arch Linux, by [davy](https://bbs.archlinux.org/viewtopic.php?id=50845)
 * motd-trump: makes logging in great again! *may cause xenophobia and/or wall
   building*
 * [munin](http://munin-monitoring.org/): host/network monitoring done right
 * [mysql](https://mariadb.org/): setup MariaDB to use UTF-8 by default
 * [nginx](http://nginx.org/): nginx webserver setup with SSL/HTTPS, PHP, and
   munin monitoring
 * nobeep: stop annoying PC Speaker beeping
 * [pacman](https://wiki.archlinux.org/index.php/Pacman): Arch Linux's package
   manager: enable color, multilib, and pacman's pacman (as in the game)
 * quirk-fixes-laptop: various bug fixes that took me forever to find a fix for:
   slow USB flash drive speed and choppy video/flash performance using intel's
   driver
 * quirk-fixes-linode: fix various boot errors caused by a custom Arch Linux
   image (I would use their image, but it's beyond old!)
 * [samba](https://www.samba.org/): share mount points and home directories,
   with [mDNS](https://en.wikipedia.org/wiki/Multicast_DNS) .local hostname
   resolution via [Avahi](https://github.com/lathiat/avahi)
 * [ssh](http://www.openssh.com/): [more secure](https://stribika.github.io/2015/01/04/secure-secure-shell.html)
   client and server defaults plus a super secret banner
 * [unbound](https://unbound.net/): why query DNS servers when we can run one
   faster locally, with results straight from
   [the horse's mouth](https://www.internic.net/domain/named.cache) (so to
   speak), and without ISP censorship or spying. Also, efficient low level
   adblocking
 * [vnstat](http://humdi.net/vnstat/)-{laptop,server}: basic bandwidth stats and
   graphing

### Unmaintained configs
Located in the `unmaintained` folder:

 * [dunst](http://knopwob.org/dunst/): lightweight notification daemon
 * [firefox](https://www.mozilla.org/en-US/firefox/new/): force lock settings to
   disable built-in crapware, bad design decisions, and privacy issues. Note
   that this has become a pain to maintain, so I've switched to
   [Pale Moon](http://www.palemoon.org/) which is a optimized stripped down
   version of Firefox
 * [fluidsynth](https://wiki.archlinux.org/index.php/FluidSynth): play MIDI
   audio. Working config for Arch Linux; package points to the wrong location
   for the FluidR3 soundfont

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
Copyright &copy; 2016 -2017 Timothy Keith

Licensed under the [MIT license](https://github.com/keithieopia/dotfiles/blob/master/LICENSE).

*This is free software: you are free to change and redistribute it. There is NO
WARRANTY, to the extent permitted by law.*
