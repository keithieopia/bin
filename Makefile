# Makefile is notoriously obsessive with tabs, change it to be slightly more
# user friendly by using a ">" instead
.RECIPEPREFIX = >

# If no target was specified, run the one that matches our hostname
# this target must come first!
HOST = $(shell hostname)
default: $(HOST)

##
## Actual stow targets
##
everywhere:
> stow bash git nano ssh wget zsh

desktop: everywhere
> stow mpv youtube-dl xdg-user-dirs
> sudo stow -t / quirk-apt-no-recommend

servers: everywhere
> sudo stow -t / quirk-oom-killer-reboot sshd

web_server: everywhere servers
> sudo stow -t / lighttpd php
> sudo mkdir -p /etc/lighttpd/sites-enabled /etc/lighttpd/conf-enabled

home_server: everywhere servers web_server
> sudo stow -t / emby quirk-no-lid-suspend quirk-apt-block-pkgs

git_server: everywhere servers
> sudo stow -t / cgit

##
## hostnames
##

# this is my personal laptop
deli: desktop
> sudo stow -t / xorg

# this is a VPS on linode
linda: web_server git_server
> test -L /etc/lighttpd/sites-enabled/keithieopia.conf || sudo ln -s /etc/lighttpd/sites-available/keithieopia.conf /etc/lighttpd/sites-enabled/
> test -L /etc/lighttpd/sites-enabled/kerriandtimothy.conf || sudo ln -s /etc/lighttpd/sites-available/kerriandtimothy.conf /etc/lighttpd/sites-enabled/

# this is my home media server
minime: home_server
> test -L /etc/lighttpd/sites-enabled/minime.conf || sudo ln -s /etc/lighttpd/sites-available/minime.conf /etc/lighttpd/sites-enabled/
> sudo stow -t / quirk-no-ipv6