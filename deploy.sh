#!/bin/sh

REPO="https://github.com/keithieopia/dotfiles.git"

deployer() {
	echo
	echo "DOWNLOADING..."
	echo "--------------"
	git clone -b $BRANCH $REPO $TMPGITDIR
	echo

	if [ "$?" -eq 0 ]; then
		cd $TMPGITDIR
		git config status.showUntrackedFiles no
	else
		echo "$BRANCH does not have any configuration available (git branch not found)"
		rm -rf $TMPGITDIR
		exit 1
	fi

	if [ -d "$TARGETDIR.git" ]; then
		echo "$TARGETDIR IS ALREADY UNDER VCS, CHECKING..."
		echo "--------------------------------------------"
		git remote add -f tmp $TARGETDIR >/dev/null 2>&1
		git remote update >/dev/null 2>&1

		GITDIFF=$(git diff $BRANCH remotes/tmp/$BRANCH | wc -c)
		rm -rf $TMPGITDIR

		if [ "$GITDIFF" -ne 0 ]; then
			echo "$TARGETDIR is already under version control, and it differs from the"
			echo "origin repo. Refusing to continue to prevent data lost. Fix by "
			echo "removing $TARGETDIR.git' or push it's changes to the remote repo"
			exit 1
		else
			echo "$TARGETDIR repo matches remote master repo, scrapping our downloaded copy"
		fi
	else
		sudo mv -r $TMPGITDIR/.git $TARGETDIR
		rm -rf $TMPGITDIR
	fi

	cd /

	if ! git status | grep -q "nothing to commit"; then
		echo
		echo "LOCAL CONFLICTING CHANGES FOUND!"
		echo "--------------------------------"
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
			echo "You can manually run 'cd $TARGETDIR && git reset --hard' as root later if you wish"
			exit 1
		fi
	fi
}

echo "##"
echo "## DEPLOYING SYSTEM CONFIGS"
echo "############################################################"

BRANCH=$(hostname)
TMPGITDIR=$(mktemp -d /tmp/$(basename $0).XXXXXX)
TARGETDIR="/"
deployer

echo
echo "##"
echo "## DEPLOYING DOTFILES"
echo "############################################################"

BRANCH="master"
TMPGITDIR=$(mktemp -d /tmp/$(basename $0).XXXXXX)
TARGETDIR="$HOME/"
deployer
