# dotfiles: ~/bin
These are the shell scripts I have in my `$PATH`. Most are quite useful, 
but some are simply novelties to see if a certain problem could be 
solved in a humble shell script.

You may want to visit the main repo [README.md](https://github.com/keithieopia/dotfiles/blob/master/README.md) 
first, if you came here directly from somewhere else.

## Table of Contents:

- `fun/`
	- `busy`: Look busy to those annoying people who shoulder surf
	- `disco`: 
	   Randomly colored lights in the terminal. For a more wholesome 
	   experience, [play this](https://www.youtube.com/watch?v=A_sY2rjxq6M) 
	   simultaneously. (Author: [Aaron Toponce](https://pthree.org/2016/01/21/using-your-monitors-as-a-cryptographically-secure-pseudorandom-number-generator/) / License: *public domain*)
	- `quotes`: Random curated quotes in a easy to understand all-in-one format (compared to [fortune](https://en.wikipedia.org/wiki/Fortune_%28Unix%29))
	- `swatch-internet-time`: get the current [internet time](https://en.wikipedia.org/wiki/Swatch_Internet_Time) / .beat time; a form of decimal time created by Swatch for their "Beat" watches
	- `rand-uncyclopedia`: 
	  random nonsensical snippets from [Uncyclopedia](http://uncyclopedia.wikia.com/wiki/Main_Page). 
	  A hilarious replacement for fortune or MOTDs. Found in a /r/linux 
	  reddit thread: "*[A simple and hilarious replacement for fortune](https://www.reddit.com/r/linux/comments/6lx7qr/a_simple_and_hilarious_replacement_for_fortune/)*". 
	  (Author: [/u/keenerd](https://www.reddit.com/user/keenerd) / License: *assumed to be attribution-only or public domain*)

- [wallpaper/](https://github.com/keithieopia/bin/blob/master/wallpaper/README.md)
- `backup`: Automatically backup using rsync and tar.gz if space is available
- `base64-img`: Convert an image to base64, suitable for [Data URIs](https://en.wikipedia.org/wiki/Data_URI_scheme) for HTML or CSS
- `clean`: Erases files, directories, browser cache, junk files, history files, and slack space
- `dd-status`: Make long-running `dd` operations print their current status
- `digests`: List the various hashsums for a file and create or verify a SHA256SUMS for a directory.
- `encrypt`: Wrapper for GPG symmetric encryption using AES256
- `extract`: Wrapper to extract from many archives
- `freedns-client`: DDNS client for [afraid.org](https://freedns.afraid.org/)
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
- `sl`: cure mistyping bad habits. Slightly more useful than the ubiquitous [steam locomotive](https://github.com/mtoyoda/sl)
- `speedtest`: A nice cli network speed test without additional dependances
- `tclock`: A nice fullscreen console clock
- `test-colors`: Show the current terminal color scheme
- `update-firefox`: Download and install locally the latest Firefox. Suitable for Debian users who want the latest Firefox over Firefox ESR
- `update-youtube-dl`: Download and install locally the latest youtube-dl version
- `weather.py`: Plaintext weather forecast from NOAA. Generally more timely and accurate compared to commercial websites and APIs
- `webserver.py`: start a simple webserver running on port 8080 in the current directory
- `whois`: trivial whois replacement that filters annoyingly large legal notices
- `youtube-dl-parallel`: Download a large list of videos simultaneously using [youtube-dl](https://rg3.github.io/youtube-dl/) and [GNU Parallel](https://www.gnu.org/software/parallel/)
- `youtube-play`: Stream a youtube video using mpv, or fallback to downloading and playing it locally

## Usage
Complex shell scripts *usually* include a help/usage statement that can 
be invoked by passing the typical `-h` flag.

