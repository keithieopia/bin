# dotfiles: everywhere

Per-user configs, found in my $HOME; most people know these as 
dotfiles. These are used on every machine I use, and mostly configure 
console programs.

You may want to visit the main repo [README.md](https://github.com/keithieopia/dotfiles/blob/master/README.md) 
first, if you came here directly from somewhere else.

* [bash](https://www.gnu.org/software/bash/): the quintessential Bash
  shell. Includes my `~/.bashrc`, `~/.bash_profile`, aliases and 
  functions
* [git](https://git-scm.com/): since you're in a git repo, I assume you
  know what this is. My settings enable color, set the default GPG key, 
  and allow pushing to non-bare repos
* [nano](https://www.nano-editor.org/): the famous editor, which IMHO 
  can be setup to be just as powerful as emacs and vi(m) as strictly 
  just an editor. This cleans up the GUI, use spaces for tabs, syntax 
  highlights, and adds mouse support
* [ssh](http://www.openssh.com/): OpenSSH client settings. Keeps the 
  connection alive, enables compression, and setups host shortcuts
* [wget](https://www.gnu.org/software/wget/): console download manager.
  This sets saner defaults so you're not waiting forever for failed 
  downloads. Also, spoof the user agent to avoid server-based 
  discrimination
