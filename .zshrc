# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
export EDITOR=vim
export VISUAL=vim
export BROWSER=google-chrome-stable
export PAGER=less
export MANPAGER=less

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && eval "$(/usr/bin/lesspipe.sh)"

[[ $- = *i* ]] && source ~/bin/liquidprompt/liquidprompt

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

source ~/bin/liquidprompt/liquidprompt
