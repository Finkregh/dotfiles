# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# This line was appended by KDE
# Make sure our customised gtkrc file is loaded.
export GTK2_RC_FILES=$HOME/.gtkrc-2.0




# via http://www.cboltz.de/de/linux/bashprompt/
# PS1version=' \[\e[46m\]8.1\[\e[0m\]'
PS1error='$( ret=$? ; test $ret -gt 0 && echo "\[\e[41;93m\]   [$ret]   \[\e[0m\]" )'
PS1user="$( test `whoami` == root && echo '\[\e[41m\]' )\u\[\e[0m\]"
PS1color='\[\e[1;37;44m\]' # Farbe Arbeitsverzeichnis
PS1="$PS1error$PS1user@\h:$PS1color\w\[\e[0m\]$PS1version> "
tty | grep pts > /dev/null && PS1="$PS1\[\e]0;\w - \u@\h\a\]";
export PS1

alias devel="ssh root@192.168.242.158"
alias xen="ssh root@xen"
alias mailssh="ssh root@mail"
alias sup="ssh support@relay.axxeo.de"

alias ipcalc="ipcalc -n"

alias vless='vim -u /usr/share/vim/vim70/macros/less.vim'
alias dig='dig +multiline'

alias clean_svn_metadata='find . -type d -name ".svn" -print0 | xargs -0 rm -rdf'

HISTSIZE=10000

#LESS man page colors
export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'                           
export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

