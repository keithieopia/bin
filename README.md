# dotfiles [ ![Codacy Badge](https://api.codacy.com/project/badge/Grade/45075b8bb6664b8c82e1b5d1f707fe7c)](https://www.codacy.com/app/timothykeith/dotfiles) [![MIT License](https://img.shields.io/github/license/keithieopia/dotfiles.svg)](https://github.com/keithieopia/dotfiles/blob/master/LICENSE) [![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/keithieopia)

> These are my dotfiles. There are many dotfile repos, but this one is mine.
>
> My dotfiles are my best friend. They are my life. I must master what 
> they config as I must master my life. 
>
> Without me, my dotfiles are useless. Without my dotfiles, I am useless.
>
> -- The Linux User's Creed

These are the config files I use for my environment and the various 
shell scripts I have in my `$PATH`. Most are quite useful, but some are 
simply novelties to see if a certain problem could be solved in a humble 
shell script.

#### Table of Contents
- [Overview](#overview)
- [Installing](#stow)
- [Feedback](#feedback)
- [Author](#author)

<img alt="Mad Madam Mim as a Dragon" style="padding-right: 8px" align="left" src="https://raw.githubusercontent.com/keithieopia/dotfiles/master/.readme-assets/mad_madam_min.png">

**Obligatory Warning**  
You should first fork this repository, review the code, and remove 
things you don't want or need. Don't blindly use my settings unless you 
know what that entails. *Here be dragons!*

## Overview
<a name="overview"></a>
Here's a high level overview if you just want to see what I use:

| Category           | Program                                                                              |
| ------------------ | ------------------------------------------------------------------------------------ |
| **Distro**:        | [Xubuntu](https://xubuntu.org/)                                                      |
| **Browser**:       | [Firefox](https://www.mozilla.org/en-US/firefox/new/)                                |
| **Shell**:         | [Zsh](http://zsh.sourceforge.net/)                                                   |
| **Shell Plugins**: | [Antigen](http://antigen.sharats.me/) & [Oh-My-Zsh](http://ohmyz.sh/)                |
| **Shell Theme**:   | [Solarized Dark](https://ethanschoonover.com/solarized/)                             |
| **Editor**:        | [Neovim](https://neovim.io/)                                                         |
| **IDE**:           | [Geany](https://www.geany.org/)                                                      |

## Installation / Managing
<a name="stow"></a>
These dotfiles are managed with [stow](http://www.gnu.org/software/stow/), 
which allows you to group dotfiles based on the programs they configure. 
Thus, you can pick and choose which dotfiles you want to install.  

For instance, to install all the related bash dotfiles:

```console
$ cd ~  
$ git clone https://github.com/keithieopia/dotfiles.git  
$ cd ~/dotfiles  
$ stow bash
```

Some dirs are for system config files, like those found in `/etc`. For 
those, pass the `-t /` flag as root. Example for OpenSSH server configs:

```console
$ sudo stow -t / sshd
```

### This seems to be a pain... how do you *really* manage it?

With a Makefile, believe it or not. It has targets for all my machines 
by hostname, which auto installs all of the relevant stow targets. It 
sounds more complicated than it is, but makes installation a breeze. All 
I end up running is:

```console
$ cd ~/dotfiles && make
```

...and I'm all setup! For new hosts not in the Makefile, I have some 
default targets, like "desktop" or "servers" that I can use. If you have 
several hosts with different stow targets, I recommend you tryout using 
`make` instead of overthinking the problem.


## Feedback
I would love your feedback! If you found any of these configs or scripts 
useful, please send me [an email](mailto:timothykeith@gmail.com). For 
the privacy conscious, feel free to encrypt any messages using my 
[PGP key](https://gist.githubusercontent.com/keithieopia/434f3575ec1f020d6589a4c01dc0847e/raw/2e0749f2966ff501ee28797a926229c081f7e652/timothykeith.pub.asc):

> 46E6 9F69 90C1 DE8C 9791 88EE 94A4 E2D4 *6B32 AA11*

To import it into your keyring:
```console
$ curl https://gist.githubusercontent.com/keithieopia/434f3575ec1f020d6589a4c01dc0847e/raw/2e0749f2966ff501ee28797a926229c081f7e652/timothykeith.pub.asc | gpg --import -
```

**NOTE:** SKS Public Key Servers (such as pgp.mit.edu) don't support 
Curve25519 keys yet. In the meantime, consider using 
[Keybase.io](https://keybase.io/); my username is [timothykeith](https://keybase.io/timothykeith).


### Bug Reports
Submit bug reports via GitHub's [Issue Tracker](https://github.com/keithieopia/dotfiles/issues)


## Author
Copyright &copy; 2016 - 2018 Timothy Keith, except where otherwise noted.

Licensed under the [MIT license](https://github.com/keithieopia/dotfiles/blob/master/LICENSE).

*This is free software: you are free to change and redistribute it. 
There is NO WARRANTY, to the extent permitted by law.*
