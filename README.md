## dotfiles

<img align="right" alt="Markdown Screenshot" src="https://raw.githubusercontent.com/keithieopia/dotfiles/master/.readme-assets/markdown_circle.png">

> Being a Linux user is sort of like living in a house inhabited by a large family of carpenters and architects. Every morning when you wake up, the house is a little different. Maybe there is a new turret, or some walls have moved. Or perhaps someone has temporarily removed the floor under your bed."
>  
> -- Unix for Dummies, 2nd Edition

These are various config files I use for my Linux environment and 
related programs.

#### Table of Contents
* [Overview](#overview):
* [Directory Layout](#layout)
* [Installing](#stow)
* [Feedback](#feedback)
* [Author](#author)


<img alt="Mad Madam Mim as a Dragon" style="padding-right: 8px" align="left" src="https://raw.githubusercontent.com/keithieopia/dotfiles/master/.readme-assets/mad_madam_min.png">

**Obligatory Warning**  
You should first fork this repository, review the code, and remove 
things you don't want or need. Don't blindly use my settings unless you 
know what that entails. *Here be dragons!*  

<br>

## Overview
<a name="overview"></a>
Here's a high level overview if you just want to see what I use:

| Category          | Program                                                                      |
| ----------------- | ---------------------------------------------------------------------------- |
| **Distro**:       | [Ubuntu (Minimal)](https://help.ubuntu.com/community/Installation/MinimalCD) |
| **Browser**:      | [Chromium](https://www.chromium.org)                                         |
| **Shell**:        | [Bash](https://www.gnu.org/software/bash)                                    |
| **Color scheme**: | [Base16 Eighties Dark](https://github.com/chriskempson/base16-xresources)    |
| **Editor**:       | [nano](http://www.nano-editor.org)                                           |
| **IDE**:          | [Geany](http://www.geany.org)                                                |
| **Media player**: | [mpv](https://mpv.io)                                                        |


## Directory Layout
<a name="layout"></a>
My dotfiles are organized by *machine/application* and managed by 
[GNU Stow](#stow). A suffix of `*-etc` means the configuration files are
meant for `/etc`, not `$HOME`.  

**TIP**: Running the `stow-all` script will install everything in that 
respective folder. 

### Machines:

* [desktop](https://github.com/keithieopia/dotfiles/blob/master/desktop/): 
  Geany, mpv, youtube-dl, etc
* [desktop-etc](https://github.com/keithieopia/dotfiles/blob/master/desktop-etc/): 
  Grub2, TLP, quirk fixes, etc
* [server-etc](https://github.com/keithieopia/dotfiles/blob/master/server-etc/): 
  LEMP stack, OpenSSH server, etc
* [unmaintained](https://github.com/keithieopia/dotfiles/blob/master/unmaintained/): 
  Old stuff I don't use anymore
* [unmaintained-etc](https://github.com/keithieopia/dotfiles/blob/master/unmaintained-etc/): 
  Old stuff I don't use anymore (system-wide edition)


## Installation / Managing
<a name="stow"></a>
These dotfiles are managed with [stow](http://www.gnu.org/software/stow/),
which allows you to group dotfiles based on the programs they configure. 
Thus, you can pick and choose which dotfiles you want to install.  

For instance, to install all the related bash dotfiles:

```console
$ cd ~  
$ git clone https://github.com/keithieopia/dotfiles.git  
$ cd dotfiles/everything/bash 
$ stow -t $HOME bash
```

To install any of the system config files in a `*-etc/` suffixed 
directory, change the `-t $HOME` flag to `-t /`, like so:

```console
$ cd server-etc/sshd
$ sudo stow -t / sshd
```

## Feedback
<a name="feedback"></a>
I would love your feedback! If you found any of these config files useful,
please drop me [an email](mailto:timothykeith@gmail.com). For the privacy
conscious, feel free to encrypt any messages using my [PGP key](http://pgp.mit.edu/pks/lookup?op=vindex&fingerprint=on&search=0xF4F4A135C022EE12):

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

*This is free software: you are free to change and redistribute it. There is NO
WARRANTY, to the extent permitted by law.*
