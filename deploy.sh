#!/bin/sh

HOSTNAME=$(hostname)
TMPGITDIR=$(mktemp -d /tmp/$(basename $0).XXXXXX)

echo "DOWNLOADING..."
echo "--------------"
git clone -b $HOSTNAME https://github.com/keithieopia/dotfiles.git $TMPGITDIR
echo

if [ "$?" -eq 0 ]; then
	cd $TMPGITDIR
	git config status.showUntrackedFiles no
else
	echo "$HOSTNAME does not have any configuration available (git branch not found)"
	rm -rf $TMPGITDIR
	exit 1
fi

if [ -d "/.git" ]; then
	echo "ROOT IS ALREADY UNDER VCS, CHECKING..."
	echo "--------------------------------------"
	git remote add -f root / >/dev/null 2>&1
	git remote update >/dev/null 2>&1

	GITDIFF=$(git diff $HOSTNAME remotes/root/$HOSTNAME | wc -c)
	rm -rf $TMPGITDIR

	if [ "$GITDIFF" -ne 0 ]; then
		echo "/ is already under version control, and it differs from the origin repo."
		echo "Refusing to continue to prevent data lost. Fix by removing /.git' or"
		echo "push it's changes to the remote repo"
		exit 1
	else
		echo "Root repo matches remote master repo, scrapping our downloaded copy"
	fi
else
	sudo mv -r $TMPGITDIR/.git /
	rm -rf $TMPGITDIR
fi

cd /

if ! git status | grep -q "nothing to commit"; then
	echo
	echo "LOCAL CHANGES TO CONFIG FOUND!"
	echo "------------------------------"
	echo "Some files differ from what's tracked in git, check the following"
	echo "files as they will be overwritten: "
	echo

	git status | grep "modified:" | awk '{print $2}'
	echo

	echo -n "Overwrite the above files (y/n)? "
	read answer

	if [ "$answer" != "${answer#[Yy]}" ]; then
		sudo git reset --hard
	else
		echo
		echo "You requested not to continue, so no files where changed"
		echo "You can manually run 'cd / && git reset --hard' as root later if you wish"
		exit 1
	fi
fi
