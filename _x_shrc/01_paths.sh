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
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
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
export NODENV_ROOT="$HOME/.nodenv"
export PATH="$NODENV_ROOT/bin:$PATH"
if command_exists 'nodenv' ; then
  eval "$(nodenv init -)"
fi

# scala
export PATH=$PATH:$HOME"/Library/Application Support/Coursier/bin"


# OPAM configuration
if [ -s $HOME/.opam ]; then
  . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi

# mysql
# export PATH=/usr/local/mysql/bin:$PATH

# editor
export EDITOR=nvim

# rust
export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"

# flutter
# https://docs.flutter.dev/get-started/install/macos
export PATH="$PATH:$HOME/.flutter/bin"
export FLUTTER_GIT_URL=ssh://git@github.com/flutter/flutter.git

# Android Studio
# https://developer.android.com/studio/command-line/variables?hl=ja#set
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
