##
## Text file operations
##

# get a random line from a file
randomline () {
    if [ "$1" ];then  #checking if we were passed a filename/variable
        FileName="$1"  #just an easier variable to work with
        if [ ! -f "$FileName" ];then  #check if it is a file
            echo "Err: $FileName is not a file"
        fi
        #Count how many lines in the file
        LineCount="$(wc -l "$FileName" | cut -f 1 -d ' ')"
        #Dont continue if we have less than 1 line
        if [ "$LineCount" -gt "1" ];then
            #Test past.. selecting random line
            TargetLine=$[ ( $RANDOM % $LineCount )  + 1 ]
            Output="$(sed -n "${TargetLine}p" "$FileName")"
            echo "$Output"
        else
            echo need a file with more than 1 line... cmon...
        fi
    else
        #seems we didnt get any input
        echo "Please specify a text file"
    fi
}

# Character / Word counts
alias charcount='wc -c $1'
alias wordcount='wc -w $1'

# Most frequent used words of text file
word_freq () {
    cat "$1" | tr -cs "[:alnum:]" "\n"| tr "[:lower:]" "[:upper:]" | awk '{h[$1]++}END{for (i in h){print h[i]" "i}}'|sort -nr | cat -n | head -n 30
}
