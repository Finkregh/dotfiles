#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

export HISTIGNORE="&:[bf]g:exit"
export HISTCONTROL=ignoredups
# read this number of lines into history buffer on startup
# carefull with this, it will increase bash memory footprint and load time
export HISTSIZE=100000
# HISTFILESIZE is set *after* bash reads the history file
# (which is done after reading any configs like .bashrc)
# if it is unset at this point it is set to the same value as HISTSIZE
# therefore we must set it to NIL, in which case it isn't "unset",
# but doesn't have a value either, go figure
export HISTFILESIZE=""

export PATH="$PATH:$HOME/bin:$HOME/go/bin"
export EDITOR=vim
export VISUAL=vim
export BROWSER=google-chrome-stable
export PAGER=less
export MANPAGER=less

#LESS man page colors
export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'                           
export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

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




if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && eval "$(/usr/bin/lesspipe.sh)"

#for file in `find ~/.bash_completion.d/* -maxdepth 0 -type l` ; do . $file ; done


if [ -x /usr/bin/keychain ] ; then
    [ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
    [ -f $HOME/.keychain/$HOSTNAME-sh ] && \
        . $HOME/.keychain/$HOSTNAME-sh
    [ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
        . $HOME/.keychain/$HOSTNAME-sh-gpg

    keychain --quiet
    eval $(keychain --systemd --quiet --eval)
    /usr/bin/keychain --systemd ~/.ssh/id_rsa
    /usr/bin/keychain --systemd ~/.ssh/id_rsa
    #eval $(/usr/bin/keychain --eval --systemd ~/.ssh/id_rsa.frv)
    eval $(keychain --quiet --eval)
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
