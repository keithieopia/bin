# dotfiles: server (system-wide)
These are system configuration files used on my server. More traditional
dotfiles for things like Bash and nano can be found in the 
[everywhere](https://github.com/keithieopia/dotfiles/blob/master/everywhere/README.md) 
directory.

You may want to visit the main repo [README.md](https://github.com/keithieopia/dotfiles/blob/master/README.md) 
first, if you came here directly from somewhere else.

* lemp: Linux, [nginx](https://nginx.org/), [MariaDB](https://mariadb.org/), 
  and [PHP](http://php.net/) stack
* reboot-on-out-of-memory: on servers it's sometimes a better choice to 
  restart then let the [OOM Killer](https://linux-mm.org/OOM_Killer)
  have its way with our precious daemons
* [sshd](http://www.openssh.com/): OpenSSH server settings. More secure 
  timeouts, [better ciphers choices](https://stribika.github.io/2015/01/04/secure-secure-shell.html),
  and set a humorous banner that avoids boring legal drivel
