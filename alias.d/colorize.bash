## 
## Color piped output from scripts
## Usage: echo "This is green!" | colorize GREEN
##

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
PINK="95"
LIGHTCYAN="96"

ESC="\033["


# Regular colors
colorize(){
    color=\$${1:-NORMAL}

    echo -ne "${ESC}0;`eval echo $color`m"
    cat
    echo -ne "${ESC}0m"
}

# Light colors
lcolorize(){
    color=\$${1:-NORMAL}

    echo -ne "${ESC}2;`eval echo ${color}`m"
    cat
    echo -ne "${ESC}0m"
}

# Bold colors
bcolorize(){
    color=\$${1:-NORMAL}

    echo -ne "${ESC}1;`eval echo ${color}`m"
    cat
    echo -ne "${ESC}0m"
}

# Underlined Colors
ucolorize(){
    color=\$${1:-NORMAL}

    echo -ne "${ESC}4;`eval echo ${color}`m"
    cat
    echo -ne "${ESC}0m"
}
