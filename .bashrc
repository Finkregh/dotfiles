#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

if [ -x /usr/bin/keychain ] ; then
    [ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
    [ -f $HOME/.keychain/$HOSTNAME-sh ] && \
        . $HOME/.keychain/$HOSTNAME-sh
    [ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
        . $HOME/.keychain/$HOSTNAME-sh-gpg

    keychain --quiet
    eval $(keychain --systemd --quiet --eval)
    eval $(/usr/bin/keychain --eval --systemd ~/.ssh/id_rsa)
    eval $(/usr/bin/keychain --eval --systemd ~/.ssh/id_rsa.frv)
    eval $(keychain --quiet --eval)
fi

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

export PATH="$PATH:$HOME/bin"
export EDITOR="vim"

