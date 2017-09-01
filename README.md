# ~/bin [![Codacy Badge](https://api.codacy.com/project/badge/Grade/a2be672889a848609315c6173ebd7766)](https://www.codacy.com/app/timothykeith/bin)

<img align="right" alt="Shebang" src="https://raw.githubusercontent.com/keithieopia/bin/master/.readme-assets/shebang.png">

> Most good programmers do programming not because they expect to get paid or
> get adulation by the public, but because it is fun to program.
>  
> -- Linus Torvalds

These are various shell scripts I have in my `$PATH`. Most are quite useful, but some are simply novelties to see if a certain problem could be solved in a humble shell script.


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
- `youtube-dl-parallel`: Download a large list of videos simultaneously using [youtube-dl](https://rg3.github.io/youtube-dl/) and [GNU Parallel](https://www.gnu.org/software/parallel/)
- `youtube-play`: Stream a youtube video using mpv, or fallback to downloading and playing it locally


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
