if [[ "$os" == "Linux" ]]; then
        if [[ "$USER" == "root" ]]; then
        #root
                alias ag='apt-get'
        else
                alias ag='sudo apt-get'
        fi
        alias agi='ag install'
        alias agu='ag update'
        alias agug='ag upgrade'
        alias agdu='ag dist-upgrade'
        alias ac='apt-cache';
        alias acs='ac search';
fi
