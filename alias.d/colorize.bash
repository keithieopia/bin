# colorize(): Color piped input easily!
# Usage: echo "This is green!" | colorize GREEN
#
# Copyright (c) 2016 Timothy Keith
# The BSD 2-Clause License (BSD) https://opensource.org/licenses/BSD-2-Clause

# shades
WHITE="97"
LIGHTGRAY="37"
DARKGRAY="90"
BLACK="30"

# regular colors
RED="31"
GREEN="32"
YELLOW="33"
BLUE="34"
PURPLE="35"
CYAN="36"

# light colors
LIGHTRED="91"
LIGHTGREEN="92"
LIGHTYELLOW="93"
LIGHTBLUE="94"
LIGHTPURPLE="95"
LIGHTCYAN="96"

ESC="\033["

colorize() {
    case $1 in
        "BOLD")
            SET="1"
            COLOR=\$${2:-NORMAL}
            ;;
        "DIM")
            SET="2"
            COLOR=\$${2:-NORMAL}
            ;;
        "UNDERLINE")
            SET="4"
            COLOR=\$${2:-NORMAL}
            ;;
        *)
            SET="0"
            COLOR=\$${1:-NORMAL}
            ;;
    esac
        
    echo -ne "${ESC}${SET};`eval echo ${COLOR}`m"
    cat
    echo -ne "${ESC}0m"
}
