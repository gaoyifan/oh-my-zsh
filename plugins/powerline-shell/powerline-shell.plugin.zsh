function powerline_precmd() {
	export PS1="$($ZSH/plugins/powerline-shell/powerline-shell.py $? --shell zsh 2> /dev/null)"
	export RPS1='%(?..%{[0m%}%{[38;5;124m%}%{[38;5;254m%}%{[48;5;124m%} $?%{[48;5;124m%}) %{[38;5;236m%}%{[38;5;15m%}%{[48;5;236m%} %D{%H:%M:%S} %{[0m%}'
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
