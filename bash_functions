function psearch {
    # Search within ps aux output for a process name, exclude grep process
    ps aux | grep -v "grep" | grep $1 
}

function tord_find {
    # Find recursively from currentdir a list of names andr return them in time-ordered fashion
    for n in $@ 
    do 
        lt $(find . -name $n)
    done
}

function strip_str {
    # Just a basic wrapper around sed sub method
    # Remove given string from stream
    sed "s:$1:: ;"     
    # Should be recursive with many strings.
    # Actually, it should be a python program in the bin I gues...
}

function hgrep {
    # Search in history for arg and exlude grep searches
    history | grep -v grep | grep $1 
    # Very rudimental... 
    # You should write it recursively and in such way that it excludes only the grep search of this argument
    #for str in $@ 
    #do
    #    grep grep -v grep |
}

#---------------------------------------------
# Thanks to andreatsh (https://github.com/andreatsh/dotfiles/blob/master/.bash_functions)
#--------------------------------------------
function swap() {
    local TMPFILE="swaptemp.$$"

    [ "$#" -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e "$1" ]  && echo "swap: $1 does not exist"  && return 1
    [ ! -e "$2" ]  && echo "swap: $2 does not exist"  && return 1

    mv "$1" "$TMPFILE"
    mv "$2" "$1"
    mv "$TMPFILE" "$2"
}

function bck() {
    [ ! -e "$1" ] && echo "bck: $1 file not found" && return 1
    cp "$1" "$1_$(date +%Y%m%d-%H%M%S)"
}
