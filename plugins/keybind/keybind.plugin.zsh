# Description
# ------------
#
# exit plugin will bind a key meta-E to type exit in the current shell
#
# ------------------------------------------------------------
# Authors
# ---------
#
# Yifan Gao <ylgaoyifan@gmail.com>
#
# ------------------------------------------------------------
#

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey -s "^[e" "^U^Cexit\n"
bindkey -s "^[r" "^Ureboot"
bindkey "^[s" sudo-command-line

