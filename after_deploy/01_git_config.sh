#!/bin/sh

# git config
if command_exists git ; then
  if [ "`git remote -v | grep https`" ]; then
    # https
    new_origin='https://github.com/adshidtadka/dotfiles.git'
  else
    # ssh
    new_origin='git@github.com:adshidtadka/dotfiles.git'
  fi
  set -x
  git remote set-url origin $new_origin
  { set +x; } 2>/dev/null

  # set vim as commit message editor
  git config --global core.editor 'nvim'
  # enable gitignore_global
  git config --global core.excludesfile ~/.gitignore_global
  # colorful
  git config --global color.ui true
  git config --global color.diff auto
  git config --global color.status auto
  git config --global color.branch auto
fi

