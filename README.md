# ~/bin [![Codacy Badge](https://api.codacy.com/project/badge/Grade/a2be672889a848609315c6173ebd7766)](https://www.codacy.com/app/timothykeith/bin)

<img align="right" alt="Shebang" src="https://raw.githubusercontent.com/keithieopia/bin/master/.readme-assets/shebang.png">

> Most good programmers do programming not because they expect to get paid or
> get adulation by the public, but because it is fun to program.
>  
> -- Linus Torvalds

These are various shell scripts I have in my `$PATH`. Most are quite 
useful, but some are simply novelties to see if a certain problem could 
be solved in a humble shell script.


## Table of Contents:

- `backup`: Automatically backup using rsync and tar.gz if space is available
- `base64-img`: Convert an image to base64, suitable for [Data URIs](https://en.wikipedia.org/wiki/Data_URI_scheme) for HTML or CSS
- `clean`: Erases files, directories, browser cache, junk files, history files, and slack space
- `dd-status`: Make long-running `dd` operations print their current status
- `digests`: List the various hashsums for a file and create or verify a SHA256SUMS for a directory.
- `encrypt`: Wrapper for GPG symmetric encryption using AES256
- `extract`: Wrapper to extract from many archives
- `freedns-client`: DDNS client for [afraid.org](https://freedns.afraid.org/)
- *fun/*
    - `busy`: Look busy to those annoying people who shoulder surf
	- `disco`: Randomly colored lights in the terminal. For a more wholesome experience, [play this](https://www.youtube.com/watch?v=A_sY2rjxq6M) simultaneously
	- `quotes`: Random curated quotes in a easy to understand all-in-one format (compared to [fortune](https://en.wikipedia.org/wiki/Fortune_%28Unix%29))
- `gpg-export-key`: Backup both the public and secret key for a given GPG key
- `image-avg-color`: Find the average color of an image; useful for website development and theme building
- `letsencrypt`: Renew SSL certs for my domains using certbot
- `mirror`: Mirror a website sanely with wget
- `mount-cd`: Mounts an .iso CD/DVD image to /mnt/cdrom
- `net-status`: Show the network status as well as the Gateway and local/public IP addresses
- `nullcrypt`: Creates and opens encrypted LUKS containers with sane settings
- `optimize-images`: Optimize images for the web by reduces image size and fixing file names
- `pdf-extract`: Extract pages from a PDF; useful for removing superfluous and unofficial cover sheets added by many online repositories. Compare to [pdftk](https://linux.die.net/man/1/pdftk).
- `poor-mans-proxy`: Scrap complicated VPN setups for a simple SSH tunnel
- `rangen`: Create random passwords, MAC addresses, letters, or numbers using /dev/urandom
- `sl`: cure mistyping bad habits. Slightly more useful than the ubiquitous [steam locomotive](https://github.com/mtoyoda/sl).
- `test-colors`: Show the current terminal color scheme
- `weather.py`: Plaintext weather forecast from NOAA. Generally more timely and accurate compared to commercial websites and APIs
- `youtube-dl-update`: Download and install the latest youtube-dl version
- `youtube-dlp`: Download a large list of videos simultaneously using [youtube-dl](https://rg3.github.io/youtube-dl/) and [GNU Parallel](https://www.gnu.org/software/parallel/)


### Attic
Previously used scripts and experiments. Your mileage may vary, but some may find them useful.

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


## Usage
Complex shell scripts *usually* include a help/usage statement that can
be invoked by passing the typical `-h` flag.


## Credits

* `disco` - [Aaron Toponce](https://pthree.org/2016/01/21/using-your-monitors-as-a-cryptographically-secure-pseudorandom-number-generator/)  
  License: *public domain*
* `extract` - Based on the [ArchWiki](https://wiki.archlinux.org/index.php/Bash/Functions#Extract)
  and Vitalii Tereshchuk's [Extract](https://github.com/xvoland/Extract).  
  License: [GNU FDL](https://www.gnu.org/copyleft/fdl.html) & [MIT](https://opensource.org/licenses/MIT)
* `lemonade` - Naming convention stolen from Nathan Isom's [dotfiles](https://github.com/neeasade/dotfiles)
* `lockscreen` - Idea based on Jessie Frazelle's [i3lock-fancy](https://github.com/jessfraz/dotfiles/blob/master/bin/fancy-i3lock),
which in turn is based on Dolores Portalatin's [i3lock-fancy](https://github.com/meskarune/i3lock-fancy).  
License: [MIT](https://opensource.org/licenses/MIT)
* `test-colors` - Daniel Crisman's submission to the [TLDP's Bash Prompt HOWTO](http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html)  
  License: [GNU FDL](https://www.gnu.org/copyleft/fdl.html)


## Feedback
I would love your feedback! If you found any of these scripts useful, please
drop me [an email](mailto:timothykeith@gmail.com). For the privacy conscious,
feel free to encrypt any messages using my [PGP key](http://pgp.mit.edu/pks/lookup?op=vindex&fingerprint=on&search=0xF4F4A135C022EE12):

> 4135 C593 1D89 368E 7F32 C8ED F4F4 A135 C022 EE12

To import it into your keyring:
```console
$  gpg --keyserver pgp.mit.edu --recv-key 4135C5931D89368E7F32C8EDF4F4A135C022EE12
```

Submit bug reports via GitHub's [Issue Tracker](https://github.com/keithieopia/bin/issues)


## Author
Copyright &copy; 2016 - 2017 Timothy Keith, except where otherwise noted.

Licensed under the [MIT license](https://github.com/keithieopia/bin/blob/master/LICENSE).

*This is free software: you are free to change and redistribute it. There is NO
WARRANTY, to the extent permitted by law.*
