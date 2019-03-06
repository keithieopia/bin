# dotfiles [ ![Codacy Badge](https://api.codacy.com/project/badge/Grade/45075b8bb6664b8c82e1b5d1f707fe7c)](https://www.codacy.com/app/timothykeith/dotfiles) [![MIT License](https://img.shields.io/github/license/keithieopia/dotfiles.svg)](https://github.com/keithieopia/dotfiles/blob/master/LICENSE) [![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/keithieopia)

> These are my dotfiles. There are many dotfile repos, but this one is mine.  
> My dotfiles are my best friend. They are my life. I must master what
> they config as I must master my life.  
> Without me, my dotfiles are useless. Without my dotfiles, I am useless.
>
> -- The Linux User's Creed

These config files I use in my environment and the various shell scripts
I have in my `$PATH`. *You know... dotfiles*.

#### Table of Contents
- [Overview](#overview)
- `~/bin` **[Shell Script Listings](https://github.com/keithieopia/dotfiles/tree/master/bin/bin#dotfiles-bin)**
- [Installing](#install)
- [Feedback](#feedback)
- [Author](#author)

**Obligatory Warning**  
You should first fork this repository, review the code, and remove
things you don't want or need. Don't blindly use my settings unless you
know what that entails. *Here be dragons!*

---

## Overview
<a name="overview"></a>
Here's a high level overview if you just want to see what I use:

| Category           | Program                                                                     |
| ------------------ | --------------------------------------------------------------------------- |
| **Distro**:        | [Xubuntu](https://xubuntu.org/)                                             |
| **Browser**:       | [Firefox](https://www.mozilla.org/en-US/firefox/new/)                       |
| **Shell**:         | [Zsh](http://zsh.sourceforge.net/)                                          |
| **Shell Plugins**: | [zgen](https://github.com/tarjoilija/zgen) & [Oh-My-Zsh](http://ohmyz.sh/)  |
| **Shell Theme**:   | [Solarized Dark](https://ethanschoonover.com/solarized/)                    |
| **Editor**:        | [Neovim](https://neovim.io/)                                                |
| **IDE**:           | [Geany](https://www.geany.org/) & [Atom](https://atom.io/)                  |

## Installation / Managing
<a name="install"></a>

Installation and day-to-day management requires only git as a dependency. No
other tools or symlinking are required:


### Install

```console
$ mkdir ~/dotfiles-staging  
$ git clone --separate-git-dir=~/.dotfiles https://github.com/keithieopia/dotfiles.git dotfiles-staging
$ cp -r ~/dotfiles-staging ~
$ rm -r ~/dotfiles-staging/
```

Setting an `alias` will make management easier, the below is already included in
`.config/zsh/alias.zsh`:

```console
$ alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
### Management

Day-to-day workflow is the same, just simply replace `git` with `dots`. For instance:

```console
$ dots add ~/.bashrc
$ dots commit
$ dots push
```

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
Copyright &copy; 2016 - 2019 Timothy Keith, except where otherwise noted.

Licensed under the [MIT license](https://github.com/keithieopia/dotfiles/blob/master/LICENSE).

*This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.*
