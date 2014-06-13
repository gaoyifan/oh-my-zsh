# local pm_shell

alias pmi='pm install'
alias pmu='pm update'
alias pmug='pm upgrade'
alias pmdu='pm dist-upgrade'
alias pmr='pm remove'
alias pms='pm search'
alias pmri='pm reinstall'
alias pmif='pm info'

if `type aptitude >/dev/null 2>&1` ; then
    pm_shell='aptitude'
    if [[ "$USER" != "root" ]]; then
        pm_shell="sudo $pm_shell"
    fi
elif `type apt-get >/dev/null 2>&1` ; then
    pm_shell='apt-get'
    if [[ "$USER" != "root" ]]; then
        pm_shell="sudo $pm_shell"
    fi
    alias pms='apt-cache search'
    alias pmif='apt-cache show'
elif `type brew >/dev/null 2>&1` ; then
    pm_shell='brew'
elif `type yum >/dev/null 2>&1` ; then
    pm_shell='yum'
fi

alias pm="$pm_shell"