# dotfiles: home-server-etc

System configs for the private server found in my home.

You may want to visit the main repo [README.md](https://github.com/keithieopia/dotfiles/blob/master/README.md) 
first, if you came here directly from somewhere else.

## Services / Capabilities

I admit these configs probably won't be useful for you, however the apps/services it runs may give you inspiration for building your very own home server:


| Function | Software | Description | Similar To |
| -------- | -------- | ----------- | ---------- |
| GitHub backup | [Gogs](https://gogs.io/) | Self-hosted web interface for Git repos | GitLab |
| Streaming TV & Movies | [Emby](https://emby.media/) | Media server supporting a variety of devices | Plex, Kodi |
| Note-taking / Todo List | [DokuWiki](https://www.dokuwiki.org) | Simple wiki without the need for a database | MediaWiki  (runs Wikipedia) |
| Website Development Testing | [nginx](http://nginx.org/) | Lightweight web server, with all the features of the heavyweights  | Apache, lighttpd |

## Recycled Hardware

I use the term "server" lightly. In reality, it's nothing more than an old netbook stashed away in a cabinet. Just about anything else is more powerful. If you have your doubts, all the above runs perfectly fine on:

  * 1.66 GHz, single-core CPU
  * 2 GB of RAM
  * 150 GB hard drive (I admit I have an external drive for all my media files)

The trick is to do a minimal install, without a desktop environment or Xorg. Practically all Linux distros have a minimal (sometimes called netinst) ISO. If you're having trouble finding one, [Ubuntu Server](https://www.ubuntu.com/server) is a safe choice.