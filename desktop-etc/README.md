# dotfiles: desktop (system-wide)

These are system configuration files (e.g.: `/etc` and `/usr`) used on 
my desktop machine.

You may want to visit the main repo [README.md](https://github.com/keithieopia/dotfiles/blob/master/README.md) 
first, if you came here directly from somewhere else.

* [grub](https://www.gnu.org/software/grub/): multiboot loader. Boots
  [Ubuntu](https://www.ubuntu.com/) with [FDE](https://en.wikipedia.org/wiki/Disk_encryption#Full_disk_encryption)
  and reluctantly Windows 10, with great trepidation
* [quirks-slow-system-with-usb-drives](http://lwn.net/Articles/572911/): 
  fixes freezing found across Linux distros while copying a large amount 
  of date to and from USB drives
* quirks-ubuntu-wifi-killed-on-batt: Ubuntu will turn off the wifi 
  adapter on battery, while using wifi, even when this is disabled in 
  Settings or in NetworkManager. This nukes the adapter's power feature 
  so Ubuntu can't touch it
* [tlp](http://linrunner.de/en/tlp/tlp.html): simple power management 
  for laptops
