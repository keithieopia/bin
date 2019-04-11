#!/bin/sh

REPO="https://github.com/keithieopia/dotfiles.git"

deployer() {
	# BUG WORKAROUND:
	# git ls-remote will unexpectedly fail if not in a readable directory
	# even though it doesn't touch the local FS and only works with remote 
	# repos. To fix, we cd into $HOME before running
	cd ~
	FIND_BRANCH=$(git ls-remote --heads $REPO $BRANCH 2>/dev/null | wc -l)
	
	if [ "$FIND_BRANCH" -ne 1 ]; then
		git ls-remote --heads $REPO
		echo "$BRANCH does not have any configuration available (git branch not found)"
		exit 1
	fi

	if [ -d "$TARGETDIR.git" ]; then
		echo
		echo "DOWNLOADING..."
		echo "--------------"
		TMPGITDIR=$(mktemp -d /tmp/$(basename $0).XXXXXX)
		git clone --no-checkout -b $BRANCH $REPO $TMPGITDIR
		cd $TMPGITDIR
		git config status.showUntrackedFiles no

		echo
		echo "$TARGETDIR IS ALREADY UNDER VCS, CHECKING..."
		echo "--------------------------------------------"
		cd $TMPGITDIR
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
		echo "DOWNLOADING..."
		echo "--------------"
		git clone --no-checkout -b $BRANCH $REPO $TARGETDIR
		git config status.showUntrackedFiles no

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
	fi
}

echo "##"
echo "## DEPLOYING SYSTEM CONFIGS"
echo "############################################################"

BRANCH=$(hostname)
TARGETDIR="/"
deployer

echo
echo "##"
echo "## DEPLOYING DOTFILES"
echo "############################################################"

BRANCH="master"
TARGETDIR="$HOME/"
deployer
