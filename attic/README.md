# ~/bin/attic
Previously used scripts and experiments. Your mileage may vary, but some may find them useful.

## Table of Contents:

- `arch-get-packer`: Install [packer](https://aur.archlinux.org/packages/packer/), an [Arch Linux](https://www.archlinux.org/) [AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers)
- `battmon`: Will warn about battery levels with increasing severity and then safely shut the system down if the battery gets too low
- `cheese`: Take a picture of yourself using the webcam
- `cryptfox`: Create and launch an encrypted browser profiles
- `headset`: Connect/disconnect a bluetooth headset. Bluetooth in Linux is still crap, so the script repetitively tries to connect before giving up
- `greeting`: Sets the volume to an appropriate level given the time and says a greeting altogether mutes it depending on if it is too late at night
- `local-wiki`: Starts PHP's built-in webserver and Firefox to access a local [dokuwiki](https://www.dokuwiki.org) install. After Firefox is closed, the PHP webserver is automatically stopped.
- `mount-cache`: Create folders and files expected to be in ~/.cache normally, useful if mounted as tmpfs
- `net-wait`: Wait for the network to come up, then start the given app
- `respawn`: Indefinitely restart a program after it exits
- `rxvt`: starts `urxvtd` if it isn't running already. If it is, urxvtc is launched instead
- `say` - Use Pico TTS to speak the given text
- `steam-preload`: Quirks fixes for Steam under bspwm with an Intel graphics card
- `xkcd-pass`: xkcd's [correct horse battery staple](https://xkcd.com/936/) password scheme generator. Uses the kernel's CSPRNG, unlike most implementations
- `xkill`: `kill -9` the current active window. Meant to be invoked by a hotkey
- `zeronet`: Script to run [ZeroNet](https://zeronet.io/), a decentralized censorship resistant network, using [Tor](https://www.torproject.org/) for anonymity, with [Firefox](https://www.mozilla.org/en-US/firefox/new/) [private browsing](https://support.mozilla.org/t5/Protect-your-privacy/Private-Browsing-Use-Firefox-without-saving-history/ta-p/4473).
- *i3/*
  - *i3blocks/*
    - `bandwidth`: shows the current network speeds
    - `battery`: remaining battery, changes the icon according to charge and if plugged in
	- `colors`: called by the other i3block scripts for "warning", "error", and "success" colors, so the color scheme can be easily changed
	- `cpu`: cumulative cpu utilization across cores. Requires [sysstat](http://sebastien.godard.pagesperso-orange.fr/).
	- `disk`: disk usage
	- `email`: Unread email count for Gmail. Around 15 SLOC, written pure bash, and only depends on `curl`. Other implementations are about 100 SLOC with python/ruby/etc and require add-on libraries
	- `memory`: RAM utilization
	- `volume`: Current volume level, changes icon on mute
    - *lockscreen/*
      - `lockscreen`: Blurs and locks the screen with *Barney Fife Protection&trade;* that will make evildoers think twice!
  - `lemonade`: Start a [lemonbar](https://github.com/LemonBoy/bar) panel with useful system info, similar to conky 
- *jail/*
  - `dropbox`: Nuke dropbox's buggy auto-update mechanism and run it in a firejail sandbox
  - `firefox` - Run Firefox in a firejail sandbox

## Credits

- `lemonade`: Naming convention stolen from Nathan Isom's [dotfiles](https://github.com/neeasade/dotfiles)
- `lockscreen`: Idea based on Jessie Frazelle's [i3lock-fancy](https://github.com/jessfraz/dotfiles/blob/master/bin/fancy-i3lock),
which in turn is based on Dolores Portalatin's [i3lock-fancy](https://github.com/meskarune/i3lock-fancy).  
License: [MIT](https://opensource.org/licenses/MIT)

---
*This is part of my [~/bin](https://github.com/keithieopia/linux-guides) repo. For more information, see the main [README](https://github.com/keithieopia/bin/blob/master/README.md).*