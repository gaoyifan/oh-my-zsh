function powerline_precmd() {
  export PS1="$($powerline_bin $? 2> /dev/null)"
  export RPS1='%(?..%{[0m%}%{[38;5;124m%}%{[38;5;254m%}%{[48;5;124m%} $?%{[48;5;124m%}) %{[38;5;236m%}%{[38;5;15m%}%{[48;5;236m%} %D{%H:%M:%S} %{[0m%}'
}

function install_powerline_precmd() {
  if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    return
  fi

  local env_enable=false
  if [[ $LC_POWERLINE_FONT == true ]] || [[ $XMODIFIERS == "@im=powerline" ]]; then
    env_enable=true
  fi
  if [[ -z $powerline_bin ]] || [[ "$env_enable" == "false" ]]; then
    return
  fi
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

function get_powerline_path() {
  local os=$(uname -s)
  local arch=$(uname -m)
  local ipath=${${(%):-%x}:A:h}/powerline-${arch:l}-${os:l}
  if `type $ipath >/dev/null 2>&1`; then
    echo $ipath
  fi
}

export powerline_bin=$(get_powerline_path)
install_powerline_precmd
