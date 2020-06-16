show_remind() {
if which remind >/dev/null 2>&1; then
	#
	# this downloads events from google calendar and converts them
	# to remind's format 
	#
	GOOGLE_REMIND="$HOME/.config/remind/google-calendar"

	# provides $GOOGLE_CALS (BASH array)
	source ~/.bash_secrets

	if [ -f $GOOGLE_REMIND ]; then
		# if current reminders file is older than a day, delete it
		if [[ $(find "$GOOGLE_REMIND" -mtime +1 -print) ]]; then
			rm "$GOOGLE_REMIND" 2> /dev/null
		fi
	else
		# if there isn't a reminders file, download it
		touch "$GOOGLE_REMIND"

		for i in "${GOOGLE_CALS[@]}"; do
			# ics2rem found in python library "remind"
			# pip3 install remind
			curl -s https://calendar.google.com/calendar/ical/$i/basic.ics | ics2rem | sed '/Patch Tuesday/d' |>> $GOOGLE_REMIND 2>/dev/null
		done
	fi

    #
    # output the next two weeks
	#
	tput setaf 6
	remind -mc+2w$(tput cols) $HOME/.remind
	tput sgr0
fi
}