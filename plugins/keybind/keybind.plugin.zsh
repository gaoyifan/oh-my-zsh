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

bindkey -s "^[e" "^U^Cexit\n"
bindkey -s "^[r" "^Ureboot"
bindkey -s "^[s" "^Asudo ^E"
