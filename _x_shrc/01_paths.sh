#!/bin/sh

PATH=$PATH:/sbin:$HOME/bin

export PATH

# dotfiles
export DOTPATH="$HOME/dotfiles"

# local bin
export PATH=$HOME/.local/bin:$PATH

# brew
export PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:$PATH

# ruby, rails
export PATH="$HOME/.rbenv/bin:$PATH"
if command_exists 'rbenv' ; then
  eval "$(rbenv init - --no-rehash)"
fi

# python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command_exists 'pyenv' ; then
  eval "$(pyenv init - --no-rehash)"
fi

# postgreSQL
if command_exists 'postgres' ; then
  export PGDATA=/usr/local/var/postgres
fi

# latex
TEXLIVE_BIN=/usr/local/texlive/2017/bin/x86_64-darwin
if [ -e $TEXLIVE_BIN ]; then
  export PATH=$PATH:$TEXLIVE_BIN
fi

# go
export GOPATH="$HOME/.go"
export PATH=$PATH:$GOPATH/bin

# node
if command_exists 'nodenv' ; then
  eval "$(nodenv init -)"
fi

# nvm
# 参考: [NVM の nvm.sh を遅延ロードしてシェルの起動を高速化する - Qiita](http://qiita.com/uasi/items/80865646607b966aedc8)
if [ -s $HOME/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  NVM_DEFAULT_VERSION=`cat $NVM_DIR/alias/default`
  NVM_DEFAULT_DIR=$NVM_DIR/versions/node/$NVM_DEFAULT_VERSION
  PATH=$NVM_DEFAULT_DIR/bin:$PATH
  MANPATH=$NVM_DEFAULT_DIR/share/man:$MANPATH
  export NODE_PATH=$NVM_DEFAULT_DIR/lib/node_modules
  NODE_PATH=${NODE_PATH:A}
  nvm() {
    unset -f nvm
    . "$NVM_DIR/nvm.sh"
    . "$NVM_DIR/bash_completion"
    nvm "$@"
  }
fi

# OPAM configuration
if [ -s $HOME/.opam ]; then
  . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi

# android-studio
# export ANDROID_SDK=$HOME/Library/Android/sdk
#export PATH=$PATH:$ANDROID_SDK/emulator
# export PATH=$PATH:$ANDROID_SDK/platform-tools

# mysql
# export PATH=/usr/local/mysql/bin:$PATH

# editor
export EDITOR=nvim
