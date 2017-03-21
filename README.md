## ~/bin [![Codacy Badge](https://api.codacy.com/project/badge/Grade/a2be672889a848609315c6173ebd7766)](https://www.codacy.com/app/timothykeith/bin)

<img align="right" alt="Shebang" src="https://raw.githubusercontent.com/keithieopia/bin/master/readme-assets/shebang.png">

> Most good programmers do programming not because they expect to get paid or
> get adulation by the public, but because it is fun to program.
>  
> -- Linus Torvalds

These are various shell scripts I have in my `$PATH`. Most are quite 
useful, but some are simply novelties to see if a certain problem could 
be solved in a humble shell script.

---

## Table of Contents:

* `backup` - Automatically backup using [borg](https://borgbackup.readthedocs.io/en/stable/),
   which encrypts, uses differentials, and deduplicates stored data
* `cheese` - Take a picture of yourself using the webcam
* `clean` - Erases files, directories, browser cache, junk files, history 
   files, and slack space
* `cryptfox` - Create and launch an encrypted browser profiles
* `digests` - List the various hashsums for a file and create or verify a
   SHA256SUMS for a directory.
* `encrypt` - Wrapper for GPG symmetric encryption using AES256
* `extract` - Wrapper to extract from many archives
* `fehquote` - Sets a random quote on the current background. Reads `feh`'s
   config and uses a quote from `fortune -s`, while leaving your `.fehbg` is
   untouched
* *fun/*
    * `busy`  - Look busy to those annoying people who shoulder surf
	* `disco` - Randomly colored lights in the terminal. For a more 
	  wholesome experience, [play this](https://www.youtube.com/watch?v=A_sY2rjxq6M)
	  simultaneously
	* `quotes` - Random curated quotes in a easy to understand 
	  all-in-one format (compared to [fortune](https://en.wikipedia.org/wiki/Fortune_%28Unix%29))
* `headset` - Connect/disconnect a bluetooth headset. Bluetooth in Linux is
   still crap, so the script repetitively tries to connect before giving up
* *i3blocks/*
    * `battery` - remaining battery, changes the icon according to charge and if 
      plugged in
    * `colors` - called by the other i3block scripts for "warning", "error", and 
      "success" colors, so the color scheme can be easily changed
    * `cpu` - cumulative cpu utilization across cores. Requires [sysstat](http://sebastien.godard.pagesperso-orange.fr/).
    * `disk` - disk usage
    * `email` - Unread email count for Gmail. Around 15 SLOC, written pure bash, 
      and only depends on `curl`. Other implementations require python/ruby/etc 
      with additional libraries and are about 100 SLOC.
    * `memory` - RAM utilization
    * `pkgs` - Number of available updates for Arch Linux 
    * `volume` - Current volume level, changes icon on mute.
* *install/*
    * `arch-get-packer` - Install [packer](https://aur.archlinux.org/packages/packer/),
       an [Arch Linux](https://www.archlinux.org/) [AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers)
* `letsencrypt` - Renew SSL certs for my domains using certbot
* `local-wiki` - Starts PHP's built-in webserver and Firefox to access 
   a local [dokuwiki](https://www.dokuwiki.org) install. After Firefox is 
   closed, the PHP webserver is automatically stopped.
* `mirror` - Mirror a website sanely with wget
* `mount-cache` - Create folders and files expected to be in ~/.cache normally,
   useful if mounted as tmpfs
* `mount-cd` - Mounts an .iso CD/DVD image to /mnt/cdrom
* `net-status` - Show the network status as well as the Gateway and local/public
   IP addresses
* `net-wait` - Wait for the network to come up, then start the given app
* `nullcrypt` - Creates and opens encrypted LUKS containers with sane settings
* `optimize-images` - Optimize images for the web by reduces image size and fixing
   file names
* `pdf-extract` - Extract pages from a PDF; useful for removing superfluous and
   unofficial cover sheets added by many online repositories. Compare to
   [pdftk](https://linux.die.net/man/1/pdftk).
* `rangen` - Create random passwords, MAC addresses, letters, or numbers 
   using /dev/urandom
* `respawn` - Indefinitely restart a program after it exits
* `say` - Use Pico TTS to speak the given text
* `steam-preload` - Quirks fixes for Steam under bspwm with an Intel graphics
   card
* `test-colors` - Show the current terminal color scheme
* `weather.py` - Plaintext weather forecast from NOAA. Generally more timely and
   accurate compared to commercial websites and APIs
* *unmaintained/*
    * `lemonade` - Start a [lemonbar](https://github.com/LemonBoy/bar) panel
       with useful system info, similar to conky
* *wm/*
    * `battmon` - Will warn about battery levels with increasing severity and
       then safely shut the system down if the battery gets too low.
    * `dropbox` - Nuke dropbox's buggy auto-update mechanism and run it in a
       firejail sandbox
    * `lockscreen` - Blurs and locks the screen with *Barney Fife
       Protection&trade;*
       that will make evildoers think twice!
    * `firefox` - Run Firefox in a firejail sandbox
    * `greeting` - Sets the volume to an appropriate level given the time and
       says a greeting
       altogether mutes it depending on if it is too late at night
* `zeronet` - Script to run [ZeroNet](https://zeronet.io/), a decentralized
   censorship resistant network, using [Tor](https://www.torproject.org/) for
   anonymity, with [Firefox](https://www.mozilla.org/en-US/firefox/new/) 
   [private browsing](https://support.mozilla.org/t5/Protect-your-privacy/Private-Browsing-Use-Firefox-without-saving-history/ta-p/4473).


## Usage
Complex shell scripts *usually&trade;* include a help/usage statement that can
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
