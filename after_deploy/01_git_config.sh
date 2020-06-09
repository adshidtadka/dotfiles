#!/bin/sh

# git config
if command_exists git ; then
  # redirect old repo
  if [ "`git remote -v | grep scarletrunner7000`" ]; then
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
  fi

  # user and email
  git config --global user.name adshidtadka
  git config --global user.email nextage900fx@gmail.com

  # ghq config
  git config --global ghq.root ~/dev/src
  # set vim as commit message editor
  git config --global core.editor 'vim -c "set fenc=utf-8"'
  # enable gitignore_global
  git config --global core.excludesfile ~/.gitignore_global
  # colorful
  git config --global color.ui true
  git config --global color.diff auto
  git config --global color.status auto
  git config --global color.branch auto

  git config --global alias.st status
  git config --global alias.br branch
  git config --global alias.co checkout
  git config --global alias.mab 'merge --abort'
  git config --global alias.gr 'log --graph --oneline --decorate -10'
  git config --global alias.gn 'grep -n'

  # make sure the current branch has no conflict
  git config --global alias.mts 'merge --no-commit --no-ff'
  # side-by-side diff --cached
  git config --global alias.dfca 'diff --cached'
  # make sure there are no unnecessary spaces nor tabs
  git config --global alias.dfch 'diff --check'
  # show diff per words
  git config --global alias.dfw 'diff --word-diff'
  git config --global alias.shw 'show --word-diff'
  # edit commit's timestamp
  git config --global alias.cmad '!git commit --amend --date'
  # set upstream
  git config --global alias.pushu 'push -u'
fi

