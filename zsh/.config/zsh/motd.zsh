#!/bin/zsh


function motd() {
	DATE=$(date '+%Y-%m-%d @ %-I:%M %p')

	PKG=$(apt-get --just-print upgrade | grep Inst |  wc -l)
	SECPKG=$(apt-get --just-print upgrade | grep Inst | grep Debian-Security |  wc -l)
	MISCPKG=$(echo "$PKG - $SECPKG" | bc -l)

	LOAD=$(iostat | sed -n 4p | awk '{load=100-$6; print load "%"}')
	SWAP=$(free | grep Swap: | awk '{printf("%.2f%%\n", $3/$2*100)}')
	MEM=$(free | grep Mem: | awk '{printf("%.2f%%\n", $3/$2*100)}')

	ROOT=$(df / | tail -1 | awk '{print $5}')
	HOME=$(df /home | tail -1 | awk '{print $5}')


	if hash figlet 2>/dev/null; then
		figlet "<<<  $(hostname)  >>>"
		echo "         $DATE"
	else
		echo $(hostname) | tr '[:lower:]' '[:upper:]'
		echo "$DATE"
	fi

	printf '%40s\n' | tr ' ' -
	echo -e "CPU\tMEM\tSWAP\tROOT\tHOME\n${LOAD}\t${MEM}\t${SWAP}\t${ROOT}\t${HOME}\n" | column -c 5
	printf '%40s\n' | tr ' ' -
	
	echo

	if [ $PKG -eq 0 ]; then
		echo "System is up-to-date"
	else
		if [ $MISCPKG -gt 0 ]; then
			echo "$SECPKG security and $MISCPKG misc. updates are ready for install"
		else
			echo "$SECPKG security updates are ready for install"
		fi
	fi
}

#
# Run only on the first remote connection for each user account
#
if [ -n "$SSH_CLIENT" ] || [ "$SSH_TTY" ]; then
    LOGIN_COUNT=$(who | grep $(whoami) | wc -l)

    if [ "$LOGIN_COUNT" -lt 2 ]; then
        if hash lolcat 2>/dev/null; then
			motd | lolcat
		else
			motd
		fi
    fi
else
    exit 0
fi

