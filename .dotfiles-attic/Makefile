# If no target was specified, run the one that matches our hostname
# this target must come first!
HOST = $(shell hostname)
USER = $(shell whoami)
default: $(HOST)

##
## New machine setup
##
apt-min-install:
	sudo apt install stow
	sudo rm /etc/apt/apt.conf.d/20auto-upgrades
	sudo rm /etc/apt/sources.list
	sudo stow -t / apt

apt-purge-update: apt-min-install
	-xargs -a ./ZZ-install/apt/remove.list sudo apt purge
	sudo apt autoremove
	sudo apt update
	sudo apt upgrade
	sudo apt autoremove

setup-user:
	sudo usermod -a -G users,adm,www-data $(USER)
	chsh -s /usr/bin/zsh

##
## apt repos
##
## these do not install their respective programs as only the repos are
## needed for home-server's apt-cacher-ng setup. The desktop target
## actually installs the programs
##
repo-install-curl:
	# curl should have been installed already. this target is included
	# in case we manually run any repo-* targets before the others
	sudo apt install curl

repo-docker: repo-install-curl
	sudo stow -t / apt-repo-docker
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt update

repo-wine: repo-install-curl
	sudo dpkg --add-architecture i386
	sudo stow -t / apt-repo-wine
	curl -fsSL https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
	sudo apt update

repo-yarn: repo-install-curl
	sudo stow -t / apt-repo-yarn
	curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	sudo apt update

repo-all: repo-docker repo-wine repo-yarn


## It's not DNS
## There's no way it's DNS
## It was DNS
## -- sysadmin haiku
dns:
	sudo systemctl disable systemd-resolved.service
	sudo systemctl stop systemd-resolved
	sudo rm /etc/resolv.conf
	sudo cp dns/etc/resolv.conf /etc/resolv.conf
	sudo chattr +i /etc/resolv.conf
	sudo systemctl restart networking

##
## recipes based on machine type
##
homenet:
	sudo stow -t / apt-cacher-ng

everywhere: apt-purge-update setup-user
	xargs -a ./ZZ-install/apt/cli.list sudo apt install

	rm /home/$(USER)/.bashrc
	rm /home/$(USER)/.profile
	rm /home/$(USER)/.bash_logout
	stow -t /home/$(USER) bash git nano neovim ssh tmux wget zsh

	sudo rm /etc/systemd/system.conf
	sudo rm /etc/issue.net
	sudo rm /etc/ssh/sshd_config
	sudo stow -t / apt sshd quirk-systemd-wait-time
	sudo ufw allow ssh

desktop: everywhere repo-yarn repo-wine homenet
	xargs -a ./ZZ-install/apt/desktop.list sudo apt install

	stow mpv youtube-dl xdg-user-dirs remind
	sudo stow -t / quirk-no-wifi-powersave sudo

	# not in package lists, as they depend on stow targets:
	# repo-yarn & repo-wine
	sudo apt install yarn
	sudo apt install --install-recommends winehq-stable

servers: everywhere dns
	sudo stow -t / quirk-oom-killer-reboot

web-server: servers
#	sudo stow -t / lighttpd php
#	sudo mkdir -p /etc/lighttpd/sites-enabled /etc/lighttpd/conf-enabled
	xargs -a ./ZZ-install/apt/remove-server.list sudo apt purge
	sudo apt autoremove


home-server: servers web-server repo-all homenet
	xargs -a ./ZZ-install/apt/home-server.list sudo apt install

	sudo stow -t / plex quirk-no-lid-suspend quirk-no-wifi-powersave
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

