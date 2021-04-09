# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export LANG=en_US.UTF-8

# gather timing infos, then run zprof
#zmodload zsh/zprof

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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
#
alias fping="docker exec -ti f5vpn ping"
alias ftraceroute="docker exec -ti f5vpn traceroute"
alias ftelnet="docker exec -ti f5vpn telnet"
alias fcurl="docker exec -ti f5vpn curl"
alias ftcpdump="docker exec -ti f5vpn tcpdump"
alias fmtr="docker exec -ti f5vpn mtr"

# rather use nvim instead of vim... faster async editing
alias vim="nvim"
alias vimdiff="nvim -d"

# rather use exa instead of ls
alias ls="exa --group-directories-first"

# enable caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh

# complete proc-ids with menu
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

#export HISTIGNORE="&:[bf]g:exit"
#export HISTCONTROL=ignoredups
# read this number of lines into history buffer on startup
# carefull with this, it will increase bash memory footprint and load time
export HISTSIZE=40000
# HISTFILESIZE is set *after* bash reads the history file
# (which is done after reading any configs like .bashrc)
# if it is unset at this point it is set to the same value as HISTSIZE
# therefore we must set it to NIL, in which case it isn't "unset",
# but doesn't have a value either, go figure
#export HISTFILESIZE=""
export SAVEHIST=$HISTSIZE
## Command history configuration
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
#setopt share_history # share command history data
setopt interactivecomments # enable bash-style comments # like this
# If a command is issued that can’t be executed as a normal command, and the command is the name of a directory, perform the cd command to that directory
setopt auto_cd


export PATH="$HOME/Library/Python/3.9/bin:$HOME/Library/Python/2.7/bin:$HOME/bin:$HOME/go/bin:$PATH"
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=google-chrome-stable
export PAGER=less
export MANPAGER=less
export MANWIDTH=${MANWIDTH:-80}
export COLORTERM="yes"
export TERM=xterm-256color
export JAVA_TOOL_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
# python crashes otherwise...
# needs `ln -s /usr/local/Cellar/openssl/1.0.2t/lib/libssl.1.0.0.dylib /usr/local/lib/libssl.dylib ; ln -s /usr/local/Cellar/openssl/1.0.2t/lib/libcrypto.1.0.0.dylib /usr/local/lib/libcrypto.dylib`

export GOPATH=$HOME/go
export GOROOT=$(brew --prefix)/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

autoload -Uz compinit
compinit

. ~/.zsh_functions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && eval "$(/usr/bin/lesspipe.sh)"

#[[ $- = *i* ]] && source ~/bin/liquidprompt/liquidprompt

#export GPG_TTY=$(tty)
#gpg-connect-agent updatestartuptty /bye >/dev/null
if command -v keychain &> /dev/null ; then
    sleep 0.$[ ( $RANDOM % 9 ) ]
    eval $(keychain --quiet --eval --agents ssh --inherit any --quick)
    keychain --quick --inherit any --agents "ssh" ~/.ssh/id_rsa ~/.ssh/id_ed25519
    #keychain --quick --inherit any --agents "gpg" 0x243278FC323BBE52

    [ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
    [ -f $HOME/.keychain/$HOSTNAME-sh ] && \
        . $HOME/.keychain/$HOSTNAME-sh
    #[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
    #    . $HOME/.keychain/$HOSTNAME-sh-gpg
fi

if [ -e /opt/google-cloud-sdk/completion.zsh.inc ] ; then
    source /opt/google-cloud-sdk/completion.zsh.inc
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -e                                            # Use emacs key bindings

bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
if [[ "${terminfo[kpp]}" != "" ]]; then
  bindkey "${terminfo[kpp]}" up-line-or-history       # [PageUp] - Up a line of history
fi
if [[ "${terminfo[knp]}" != "" ]]; then
  bindkey "${terminfo[knp]}" down-line-or-history     # [PageDown] - Down a line of history
fi

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi

bindkey ' ' magic-space                               # [Space] - do history expansion

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

bindkey '^H' backward-kill-word
## use Ctrl-left-arrow and Ctrl-right-arrow for jumping to word-beginnings on
## the command line.
# URxvt sequences:
bind2maps emacs viins vicmd -- -s '\eOc' forward-word
bind2maps emacs viins vicmd -- -s '\eOd' backward-word
# These are for xterm:
bind2maps emacs viins vicmd -- -s '\e[1;5C' forward-word
bind2maps emacs viins vicmd -- -s '\e[1;5D' backward-word
## the same for alt-left-arrow and alt-right-arrow
# URxvt again:
bind2maps emacs viins vicmd -- -s '\e\e[C' forward-word
bind2maps emacs viins vicmd -- -s '\e\e[D' backward-word
# Xterm again:
bind2maps emacs viins vicmd -- -s '^[[1;3C' forward-word
bind2maps emacs viins vicmd -- -s '^[[1;3D' backward-word
# Also try ESC Left/Right:
bind2maps emacs viins vicmd -- -s '\e'${key[Right]} forward-word
bind2maps emacs viins vicmd -- -s '\e'${key[Left]}  backward-word

# ctrl-delete:
bindkey -M emacs '^[[3;5~' kill-word
# urxvt
bindkey -M emacs '^[[3^' kill-word


# BEGIN ansible-managed: ccee_tooling
if [ -r "${HOME}/.local/share/b1-ccee-environment.sh" ]; then
  source "${HOME}/.local/share/b1-ccee-environment.sh"
fi
if [ -r "${HOME}/.local/share/b1-ccee-aliases.sh" ]; then
  source "${HOME}/.local/share/b1-ccee-aliases.sh"
fi
if [ -r "${HOME}/.local/share/zsh/b1-ccee-functions.sh" ]; then
  source "${HOME}/.local/share/zsh/b1-ccee-functions.sh"
fi
# END ansible-managed: ccee_tooling
# BEGIN ansible-managed: f5_docker_connect
if [ -f "${HOME}/.local/share/f5-vpn-aliases.sh" ]; then
  source "${HOME}/.local/share/f5-vpn-aliases.sh"
fi
# END ansible-managed: f5_docker_connect

alias k=kubectl
alias ks="kubectl-sync"
alias kl="kubectl-logon"
alias kc="kubectl config use-context"
function kn { kubectl config set-context $(kubectl config current-context) --namespace }
function krc {
    for context in $(kubectl-sync ls | awk '/kubectl logon/ {print $2}'); do
        kubectl config use-context $context && \
        kubectl-logon -u $OS_USERNAME -p $OS_PASSWORD
    done
}

alias o=openstack
alias oldbrew="arch -x86_64 /usr/local/bin/brew"
alias brew="arch -arm64e /opt/homebrew/bin/brew"
#export KUBECONFIG=/Users/c5276249/.config/ccloud_multitool/kubeconfig
export PATH="/opt/homebrew/sbin:/usr/local/sbin:$PATH"
export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$(brew --prefix)/opt/gnu-tar/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix)/opt/gnu-sed/libexec/gnuman:$MANPATH"
export MANPATH="$(brew --prefix)/opt/gnu-tar/libexec/gnuman:$MANPATH"
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# GITHUB_TOKEN etc
. ~/.env-secrets

FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

# openstack-manually
function set-region {
	export OS_REGION_NAME=$1
	export OS_REGION=$1
	export OS_AUTH_URL=https://identity-3.$1.cloud.sap/v3
	kubectl config use-context $1
	monsoonctl
	monsoonctl
}

function set-project {
	export OS_PROJECT_NAME=$1
}

function set-domain {
	export OS_PROJECT_DOMAIN_NAME=$1
	export OS_USER_DOMAIN_NAME=$1
}

function set-ccadmin {
	export OS_PROJECT_DOMAIN_NAME=ccadmin
	export OS_USER_DOMAIN_NAME=ccadmin
	export OS_PROJECT_NAME=cloud_admin
}

if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  echo "perhaps run 'cd ~/dotfiles ; stow --no-folding .'"
  source ~/.zplug/init.zsh && zplug update --self
fi
source ~/.zplug/init.zsh
# let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "plugins/pass", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh, use:"_docker"
zplug "zdharma/fast-syntax-highlighting"
zplug "chrissicool/zsh-256color"
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-extras", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "chmouel/kss", use:"_kss", as:command, use:"kss"
zplug "bigH/git-fuzzy", use:"bin/git-fuzzy", as:command
zplug "plugins/asdf", from:oh-my-zsh

zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme

if ! zplug check; then
    zplug install
fi
if [ ! -e /tmp/zplug-update-timer ] ; then
    touch /tmp/zplug-update-timer
    zplug update
fi
if test $(find /tmp/zplug-update-timer -mtime +1); then
    zplug update
    touch /tmp/zplug-update-timer
fi
zplug load

## Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
## Initialization code that may require console input (password prompts, [y/n]
## confirmations, etc.) must go above this block, everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# show lockfile if it exists...
# https://github.com/zplug/zplug/issues/374
if [ -e $_zplug_lock ] ; then
    ls -la $_zplug_lock
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh
#source /usr/local/opt/gitstatus/gitstatus.prompt.zsh

# ruby garbage
eval "$(rbenv init -)"

#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# fancy logo, stats, etc
#neofetch || true

# crude daily homebrew update
if [ ! -e /tmp/brew-update-timer ] ; then
    touch /tmp/brew-update-timer
    brew update
    brew upgrade
    brew upgrade --cask
    brew cleanup --prune 30
fi
if test $(find /tmp/brew-update-timer -mtime +1); then
    brew update
    brew upgrade
    brew upgrade --cask
    brew cleanup --prune 30
    touch /tmp/brew-update-timer
fi

source /Users/c5276249/Library/Preferences/org.dystroy.broot/launcher/bash/br

# dont suspend background jobs if they produce output
stty -tostop

# BEGIN ansible-managed: ccee_tooling zsh completion
# load completions
autoload -Uz compinit
compinit
# END ansible-managed: ccee_tooling zsh completion
