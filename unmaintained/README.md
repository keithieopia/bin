# dotfiles: unmaintained
These are old, slightly worn and dusty configs. They may not work 
anymore, so use caution.

You may want to visit the main repo [README.md](https://github.com/keithieopia/dotfiles/blob/master/README.md) 
first, if you came here directly from somewhere else.

* [bspwm](https://github.com/baskerville/bspwm):
  window manager and [sxhkd](https://github.com/baskerville/sxhkd) 
  which manages hotkeys and is more or less mandatory to make bspwm
  functional
* [compton](https://github.com/chjj/compton): compositor for shadow and 
  opacity eye candy
* [dunst](http://knopwob.org/dunst/): a lightweight notification daemon
* [i3](https://github.com/Airblader/i3): a window manager, these configs 
  are actually a fork called i3-gaps, which has greater functionality 
  over vanilla [i3](https://i3wm.org/)
* quirks-adobe-flash: Adobe Flash's NPAPI plugin (e.g.: for Firefox) 
  only supports ALSA and not PulseAudio. Even at that, the plugin is too
  stupid to detect the correct sound card, resulting in no sound. This 
  is the `~/.asoundrc` fix
* [remind](https://www.roaringpenguin.com/products/remind): a easy to 
  use console calendar, alarm, and reminder program
* [rxvt](http://software.schmorp.de/pkg/rxvt-unicode.html): a terminal 
  emulator, configs are actually for the rxvt-unicode fork which sets 
  the font and color scheme, cleans up the GUI, and enables clicking on 
  URLs
* [xorg](https://www.x.org/wiki/): Set the xcursor theme, font fixes 
  (anti-aliasing, hinting, etc), and load rxvt-unicode settings (see 
  rxvt above)
