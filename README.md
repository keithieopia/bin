# INTERROBANG

**~/bin** - *Useful shell scripts in my $PATH*

Author: Timothy Keith, Copyright 2016  
License: BSD


## Synopsis

### `battmon`
Sends OSD notifications for low battery levels

Will warn about battery levels with increasing severity and then safely shut the 
system down if the battery gets too low.

Depends: _acpi, libnotify_


### `clean` 
Removes cache, backup and temporary files


### `colorize`
Color piped output from scripts

Used in most of these scripts in this repo and in the dotfiles repo.

Sample usage:  
`echo "This is Bold Red" | bcolorize RED`  
`echo "This is green!" | colorize GREEN`  
`echo "This is a lighter shade of Blue" | lcolorize BLUE`


### `cryptofox`  
Create and launch an encrypted Firefox profile

Create an encrypted profile based on an existing Firefox profile, then launch it 
and securely close it after Firefox exits.

Depends: _zenity, gksu, firefox, cryptsetup_


### `homecache`  
Create folders and files expected to be in ~/.cache normally

Highly dependent on my setup, which has ~/.cache mounted as tmpfs. Runs at login, 
with syslinks pointing to .cache for things that should be private/temporary like 
thumbnails.

See Also: _movein, dotfiles/.bash_profile_


### `movein` 
Commands to run on a new install

_a work in progress, probably won't work yet..._


### `nullcrypt` [NAME]
Creates and opens encrypted containers

Makes a empty container of a specified size, encrypts it (optionally asks for 
advanced settings), and securely mounts it. Basically a poor man's TrueCrypt

Depends: _colorize, cryptsetup, sudo_


### `optimize-images` [DIRECTORY]
Optimize images for internet use

Reduces image size and fixes file extension

Depends: _colorize, optipng, gifsicle, jpegoptim _


### `playalert`  
Plays a tune, expanding functionality in the future...

Called when a OSD notification is sent on my system

See Also: _dotfiles/dunst/dunstrc_

Depends: _libpulse_


### `respawn` [APPLICATION]  
Re-runs an application after it exits

Run `/tmp/respawnkill` to kill 
the respawn daemon


### `screenlock`
Locks the screen with a neat pixelated effect  
Runs as a screensaver with xautolock on my system

See Also: _dotfiles/openbox/autostart_

Depends: _i3lock, scrot, imagemagick_


### `see-you-space-cowboy`
Prints a rainbow homage to Cowboy Bebop  

Runs after exiting a bash session on my system

See Also: _dotfiles/.bash_logout_


### `shred-slack`
Clears slack space by creating a huge file

Depends: _dcfldd_


## Configuration
Dependencies are listed in the **Synopsis** section, see the _Depends_ line
for each respective script. Note that most scripts require the `colorize` script 
to run properly.


## Feedback
I would love your feedback! If you found any of the scripts in this git repo useful, 
please drop me [an email](mailto:timothykeith@gmail.com).

Submit bug reports via GitHub's [Issue Tracker](https://github.com/keithieopia/bin/issues)


## Author
Copyright &copy; 2016 Timothy Keith

License BSD: The BSD 2-Clause License, see [COPYING](https://raw.githubusercontent.com/keithieopia/bin/master/COPYING)

_This is free software: you are free to change and redistribute it._
_There is NO WARRANTY, to the extent permitted by law._
