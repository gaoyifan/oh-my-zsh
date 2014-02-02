# ------------------------------------------------------------
# Description
# ------------
#
# sudo will be inserted before the current command
#
# ------------------------------------------------------------
# Authors
# ---------
#
# Yifan Gao <ylgaoyifan@gmail.com>
#
# ------------------------------------------------------------
#

#Default shutcat keys alt+s
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo
