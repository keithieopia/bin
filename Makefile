# If no target was specified, run the one that matches our hostname
# this target must come first!
HOST = $(shell hostname)
default: $(HOST)

##
## New machine setup
##
install-purge-update:
	xargs -a ./ZZ-install/apt/remove.list sudo apt purge
	sudo apt autoremove
	sudo apt update
	sudo apt upgrade
	sudo apt autoremove

install-cli: install-purge-update
	xargs -a ./ZZ-install/apt/cli.list sudo apt install

install-desktop: install-cli
	xargs -a ./ZZ-install/apt/desktop.list sudo apt install

install-home-server: install-cli
	xargs -a ./ZZ-install/apt/home-server.list sudo apt install

dns:
	# It's not DNS
	# There's no way it's DNS
	# It was DNS
	# -- sysadmin haiku
	sudo systemctl disable systemd-resolved.service
	sudo systemctl stop systemd-resolved
	sudo rm /etc/resolv.conf
	sudo cp dns/etc/resolv.conf /etc/resolv.conf
	sudo chattr +i /etc/resolv.conf
	sudo systemctl restart networking

##
## Actual stow targets
##
everywhere:
	stow bash git nano neovim ssh tmux wget zsh
	sudo stow -t / apt sshd quirk-systemd-wait-time
	sudo ufw allow ssh

	git clone git@github.com:keithieopia/piu.git
	ln -s $HOME/dotfiles/piu/piu $HOME/bin/piu

desktop: everywhere
	stow mpv youtube-dl xdg-user-dirs remind
	sudo stow -t / quirk-no-wifi-powersave sudo

servers: everywhere dns
	sudo stow -t / quirk-oom-killer-reboot

web_server: everywhere servers
	sudo stow -t / lighttpd php
	sudo mkdir -p /etc/lighttpd/sites-enabled /etc/lighttpd/conf-enabled

home_server: everywhere servers web_server
	sudo stow -t / plex quirk-no-lid-suspend quirk-no-wifi-powersave apt-cacher-ng
	sudo ufw allow from 10.0.0.0/24 to any app plex
	sudo ufw allow from 10.0.0.0/24 to any app apt-cacher-ng
##
## hostnames
##

# this is my personal laptop
deli: desktop

# this is a VPS on linode
linda: web_server

# this is my home media server
lime: home_server

