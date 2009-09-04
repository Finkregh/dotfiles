# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# FIXME sometimes...
## set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#xterm-color)
	# via http://www.cboltz.de/de/linux/bashprompt/
	# PS1version=' \[\e[46m\]8.1\[\e[0m\]'
	PS1error='$( ret=$? ; test $ret -gt 0 && echo "\[\e[41;93m\]   [$ret]   \[\e[0m\]" )'
	PS1user="$( test `whoami` == root && echo '\[\e[41m\]' )\u\[\e[0m\]"
	PS1color='\[\e[1;37;44m\]' # Farbe Arbeitsverzeichnis
	PS1="$PS1error$PS1user@\h:$PS1color\w\[\e[0m\]$PS1version> "
	tty | grep pts > /dev/null && PS1="$PS1\[\e]0;\w - \u@\h\a\]";
	export PS1
#    ;;
#*)
#    PS1='\u@\h:\w\$ '
#    ;;
#esac

# == add ~/bin/ to PATH ==
if [ -d ~/bin ] ; then
	PATH="${PATH}":~/bin
fi


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# FIXME screen does not like this ...
## special screen-specific stuff for window titles
#case $TERM in
#    screen*)
#        trap 'echo -ne "\ek${BASH_COMMAND%%\ *}\e\\"' DEBUG
#        PROMPT_COMMAND='echo -ne "\ek$(short_pwd 15)\e\\"'
#        ;;
#esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# work-specifics
if [ -f ~/.bash_alias_axxeo ]; then
    source ~/.bash_alias_axxeo
fi

set TERM xterm-256color; export TERM
# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi


# add some predefined colors
GREY="\033[1;30m"
LIGHT_GREY="\033[0;37m"
CYAN="\033[0;36m"
LIGHT_CYAN="\033[1;36m"
RED="\033[00;31m"
LIGHT_RED="\033[01;31m"
GREEN="\033[00;32m"
LIGHT_GREEN="\033[01;32m"
BLUE="\033[00;34m"
LIGHT_BLUE="\033[01;34m"
NO_COLOUR="\033[0m"

export GREY LIGHT_GREY CYAN LIGHT_CYAN RED LIGHT_RED GREEN LIGHT_GREEN BLUE LIGHT_BLUE NO_COLOUR


# Make sure our customised gtkrc file is loaded.
export GTK2_RC_FILES=$HOME/.gtkrc-2.0

alias ipcalc="ipcalc -n"
alias vless='vim -u /usr/share/vim/vim70/macros/less.vim'
alias dig='dig +multiline'

alias clean_svn_metadata='find . -type d -name ".svn" -print0 | xargs -0 rm -rdf'

#LESS man page colors
export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'                           
export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


export MIKTEX_REPOSITORY=ftp://ftp.tu-chemnitz.de/pub/tex/systems/win32/miktex/tm/packages/



source ~/.bash_svn

export EDITOR=/usr/bin/vim
export HISTIGNORE="&:[bf]g:exit"
export HISTCONTROL=ignoredups
export HISTFILESIZE=10000
export HISTSIZE=10000
export INPUTRC=/etc/inputrc
export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox
export PAGER=less
export MANPAGER=less
export MAILCHECK=0


# Futurama :)
curl -Is slashdot.org | egrep '^X-(F|B|L)' | cut -d \- -f 2
