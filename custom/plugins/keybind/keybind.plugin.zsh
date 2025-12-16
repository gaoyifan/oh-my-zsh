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

bindkey "^[s" sudo-command-line

# helps with zsh-autosuggestions
bindkey '^ ' end-of-line

# allow esc+. to insert last word of last command (standard behaviour)
bindkey -M viins '^[.' insert-last-word

# allow esc+b and esc-f to move to last/next word (standard behaviour)
bindkey '^[b' backward-word
bindkey '^[f' forward-word

# allow esc+d to kill word (standard behaviour)
bindkey '^[d' kill-word

bindkey '^d' delete-char
bindkey '^f' forward-char
bindkey '^y' yank

