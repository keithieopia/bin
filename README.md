## dotfiles

<img align="right" alt="Markdown Screenshot" src="https://raw.githubusercontent.com/keithieopia/dotfiles/master/.readme-assets/markdown_circle.png">

> Being a Linux user is sort of like living in a house inhabited by a large family of carpenters and architects. Every morning when you wake up, the house is a little different. Maybe there is a new turret, or some walls have moved. Or perhaps someone has temporarily removed the floor under your bed."
>  
> — Unix for Dummies, 2nd Edition

These are various config files I use for my Linux environment and related programs.

#### Table of Contents
- [Overview](#overview)
- [Applications](#apps)
  - [Key](#apps-key)
- [Installing](#stow)
- [Feedback](#feedback)
- [Author](#author)


<img alt="Mad Madam Mim as a Dragon" style="padding-right: 8px" align="left" src="https://raw.githubusercontent.com/keithieopia/dotfiles/master/.readme-assets/mad_madam_min.png">

**Obligatory Warning**  
You should first fork this repository, review the code, and remove things you don't want or need. Don't blindly use my settings unless you know what that entails. *Here be dragons!*

<br>

## Overview
<a name="overview"></a>
Here's a high level overview if you just want to see what I use:

| Category           | Program                                                                              |
| ------------------ | ------------------------------------------------------------------------------------ |
| **Distro**:        | [Debian](https://www.debian.org/)                                                    |
| **Browser**:       | [Chromium](https://www.chromium.org)                                                 |
| **Shell**:         | [Zsh](http://zsh.sourceforge.net/)                                                   |
| **Shell Plugins**: | [Antigen](http://antigen.sharats.me/) & [Oh-My-Zsh](http://ohmyz.sh/)                |
| **Shell Theme**:   | [Sunrise](https://github.com/robbyrussell/oh-my-zsh/wiki/themes#sunrise) (modified)  |
| **Editor**:        | [nano](http://www.nano-editor.org)                                                   |
| **IDE**:           | [Kate](https://kate-editor.org/)                                                     |
| **Media player**:  | [SMPlayer](http://www.smplayer.info/) ([mpv](https://mpv.io) backend)                |


## Applications
<a name="apps"></a>
This is a list of all the applications managed in this repo. Each link to the respective project's homepage. The superscript letters have [special meaning](#apps-keys), <sup>h</sup> and <sup>r</sup> are the most important.

- [bash](https://www.gnu.org/software/bash/)<sup>a</sup>: classic Bourne shell
- [git](https://git-scm.com/)<sup>a</sup>: distributed version control
- [nano](https://www.nano-editor.org/)<sup>a</sup>: an easy to use CLI editor
- [mpv](https://mpv.io/)<sup>d</sup>: a media player on par with VLC's extensive codecs
- [quirk-no-lid-suspend](https://wiki.debian.org/Suspend)<sup>s</sup>: don't suspend when the laptop lid is closed
- [quirk-oom-killer-reboot](https://www.debuntu.org/how-to-reboot-on-oom/)<sup>sv</sup>: reboot when out of memory instead of killing processes
- [smplayer](http://www.smplayer.info/)<sup>d</sup>: A frontend for mpv
- [ssh](http://www.openssh.com/)<sup>a</sup>: secure remote shell
- [sshd](http://www.openssh.com/)<sup>sv</sup>: secure shell server
- [ufw](https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29)<sup>a</sup>: a frontend to simplify iptables
- [wget](https://www.gnu.org/software/wget/)<sup>a</sup>: console download manager
- [youtube-dl](https://rg3.github.io/youtube-dl/)<sup>d</sup>: download videos from almost any site
- [xdg-user-dirs](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/)<sup>d</sup>: control the location of default directories like ~/Desktop and ~/Downloads
- [zsh](http://zsh.sourceforge.net/)<sup>a</sup>: a shell that's slightly easier to configure
- *attic/*
  - Previously used applications and experiments. Your mileage may vary, but for some they may be useful.

### Superscript Key
<a name="apps-key"></a>

The superscript letters after application names shows which machines each configuration is used on and if you need to tell stow to place the configuration in the root directory.

#### Machines: <sup>a d s v</sup>
- <sup>a</sup> - **a**ll: bash, git, zsh, wget, ssh, nano
- <sup>d</sup> - **d**esktop: smplayer, mpv, xdg-user-dirs, youtube-dl
- <sup>s</sup> - home **s**erver: quick-no-lid-suspend, quirk-oom-killer-reboot, sshd
- <sup>v</sup> - **V**PS: quirk-oom-killer-reboot, sshd

#### Targets: <sup>h r</sup>
- <sup>h</sup> - **h**ome; a typical dotfile meant for $HOME, run stow as usual (e.g. `stow bash`)
- <sup>r</sup> - **r**oot; system configuration, such as those found in /etc. Use the target flag for the root directory (e.g. `stow -t / sshd`)


## Installation / Managing
<a name="stow"></a>
These dotfiles are managed with [stow](http://www.gnu.org/software/stow/), which allows you to group dotfiles based on the programs they configure. Thus, you can pick and choose which dotfiles you want to install.  

For instance, to install all the related bash dotfiles:

```console
$ cd ~  
$ git clone https://github.com/keithieopia/dotfiles.git  
$ cd ~/dotfiles  
$ stow bash
```

System config files are marked with a <sup>r</sup> in the above [application list](#apps). You will need to tell stow to put it in the root directory, by passing the `-t /` flag, like so:

```console
$ sudo stow -t / sshd
```

### This seems to be a pain... how do you *really* manage it?

With a Makefile, believe it or not. It has targets for all my machines by hostname, which subsequently run all of the relevant stow targets. It sounds complicated, but it's rather simple. So simple that all I run is:

```console
$ cd ~/dotfiles
$ make
```

and I'm all setup! For new hosts, I have some default make targets such as "desktop" or "servers" that usually work fine. If you have several hosts that need different stow targets, I recommend you tryout using `make` instead of overthinking the problem.

## Feedback
<a name="feedback"></a>
I would love your feedback! If you found any of these config files useful, please drop me [an email](mailto:timothykeith@gmail.com). For the privacy conscious, feel free to encrypt any messages using my [PGP key](http://pgp.mit.edu/pks/lookup?op=vindex&fingerprint=on&search=0xF4F4A135C022EE12):

> 4135 C593 1D89 368E 7F32 C8ED F4F4 A135 C022 EE12

To import it into your keyring:
```console
$  gpg --keyserver pgp.mit.edu --recv-key 4135C5931D89368E7F32C8EDF4F4A135C022EE12
```

Submit bug reports via GitHub's [Issue Tracker](https://github.com/keithieopia/dotfiles/issues)


## Author
<a name="author"></a>
Copyright &copy; 2016 - 2017 Timothy Keith

Licensed under the [MIT license](https://github.com/keithieopia/dotfiles/blob/master/LICENSE).

*This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.*
