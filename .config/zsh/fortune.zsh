show_fortune() {
if type fortune >/dev/null 2>&1; then
	tput setaf 5
	fortune -as
	tput sgr0
	echo
fi
}