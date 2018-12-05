HOST = $(shell hostname)
TODAY := $(shell date +%Y-%m-%d)
MOUNTPOINT = /media/timothy/backups
BACKUPDIR = $(MOUNTPOINT)/$(HOST)
PRIVATE_MOUNTED = $(shell lsblk -o UUID | grep 3d3a5c42-3eb1-471d-8845-d40500dce7d9)
LOGFILE = $(HOME)/backup.log
RSYNC_OPTS = -ahEPS --info=progress2 --stats --log-file=$(LOGFILE) --exclude-from rsync-exclude.txt --delete 

# Further reading:
#  https://github.com/artyom/backup-makefile/blob/master/Makefile

all: backup

prereq:
	mountpoint -q $(MOUNTPOINT)
	test -d $(BACKUPDIR) 
	test -w $(BACKUPDIR)

backup: prereq
	@ionice -c2 -n7 rsync $(RSYNC_OPTS) $(HOME)/ $(BACKUPDIR)/home-$(TODAY).incomplete || echo rsync exit code: $$?
	@mv -T $(BACKUPDIR)/home-$(TODAY).incomplete $(BACKUPDIR)/home-$(TODAY)
#	@ln -sfT $(BACKUPDIR)/home-$(TODAY) $(BACKUPDIR)/home-latest
#	@echo latest backup:
#	@readlink -e $(BACKUPDIR)/home-latest

backup-private: prereq
ifneq ($(PRIVATE_MOUNTED),)
	@echo private volume mounted, skipping
else
	rsync -ahPS --info=progress2 --stats $(HOME)/.nullcrypt-store/ $(MOUNTPOINT)/private  || echo rsync exit code: $$?
endif

.PHONY: backup prereq
