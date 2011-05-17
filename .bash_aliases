#!/bin/bash
alias cls="clear"
alias g="git"
alias umbrielssh="ssh -XYC finkregh@2001:5c0:1505:d300:20c:29ff:fe6b:24fa"

alias ipcalc="ipcalc -n"
alias vless='vim -u /usr/share/vim/vim70/macros/less.vim'
alias dig='dig +multiline'

alias clean_svn_metadata='find . -type d -name ".svn" -print0 | xargs -0 rm -rdf'

# stuff from archlinux-skel
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias vp='vim PKGBUILD'
alias vs='vim SPLITBUILD'

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# debug bash scripts
alias debug_enable="export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '"
alias debug_disable="export PS4=''"

alias man="man -LC"
alias lintian="lintian --suppress-tags bad-distribution-in-changes-file"
