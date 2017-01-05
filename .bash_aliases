alias cls="clear"
alias g="git"

alias ipcalc="ipcalc -n"
alias vless='vim -u /usr/share/vim/vim70/macros/less.vim'
alias dig='dig +multiline'

# stuff from archlinux-skel
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# debug bash scripts
alias debug_enable="export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '"
alias debug_disable="export PS4=''"

alias man="man -LC"
alias lintian="lintian --suppress-tags bad-distribution-in-changes-file"
