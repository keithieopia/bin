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
> stow bash git nano ssh ufw wget zsh

desktop: everywhere
> stow mpv smplayer youtube-dl xdg-user-dirs

servers: everywhere
> sudo stow -t / quirk-oom-killer-reboot sshd

home_server: everywhere servers
> sudo stow -t / quirk-no-lid-suspend

##
## hostnames
##

# this is my personal laptop
deli: desktop

# this is a VPS on linode
linda: servers

# this is my home media server
minime: home_server
