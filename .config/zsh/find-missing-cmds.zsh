TMPFILE=/tmp/zsh-missing-cmds

if [ ! -f /tmp/zsh-missing-cmds ]; then
	touch $TMPFILE

	grep "^have " "${HOME}/.config/zsh/alias.zsh" | awk '{print $2}' | while read line ; do
		if ! command -v $line > /dev/null 2>&1; then
			echo $line >> $TMPFILE
		fi
	done

	if [ $(wc -c $TMPFILE | awk '{print $1}') -ne 0  ]; then
		tput setaf 1
		echo "The following programs used as aliases are not installed:"
		sed 's/^/  - /' $TMPFILE
		tput sgr0
	fi
fi