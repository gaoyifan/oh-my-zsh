function powerline_precmd() {
	export PS1="$($ZSH/plugins/powerline-shell/powerline-shell.py $? --shell zsh 2> /dev/null)"
}

function install_powerline_precmd() {
	for s in "${precmd_functions[@]}"; do
		if [ "$s" = "powerline_precmd" ]; then
			return
		fi
	done
	precmd_functions+=(powerline_precmd)
}
if [ "$LC_POWERLINE_FONT" = "1" ]; then
	install_powerline_precmd
fi
