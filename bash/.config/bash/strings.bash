## 
## String Functions 
##

# rot13 caesar cipher
rot13 () { echo $@ | tr A-Za-z N-ZA-Mn-za-m; }


# Convert a hex number to different bases
hex2all () {
    if [[ $1 ]]; then
        echo "$1 in hexadecimal also equals:"
        echo "  binary:  $(hex2bin $1)"
        echo "  octal:   $(hex2oct $1)"
        echo "  decimal: $(hex2dec $1)"
        echo "  base32:  $(hex2b32 $1)"
        echo "  base64:  $(hex2b64 $1)"
        echo "  ascii:   $(hex2asc $1)"
    fi
}

hex2asc () { echo -e "\0$(printf %o $((16#$1)))"; }
hex2bin () { echo "obase=2 ; ibase=16 ; $1" | bc; }
hex2b64 () { echo "obase=64 ; ibase=16 ; $1" | bc; }
hex2b32 () { echo "obase=32 ; ibase=16 ; $1" | bc; }
hex2dec () { echo $((16#$1)); }
hex2oct () { echo "obase=8 ; ibase=16 ; $1" | bc; }
