#!/bin/sh

set -e

echo "deploying .zshrc ..."

cd $DOTPATH

echo "##### begin dotfiles #####" >> "$HOME"/.zshrc

_x_sh_shs=`ls $DOTPATH/_x_shrc/[0-9][0-9]_*.sh`
zsh_shs=`ls $DOTPATH/_zshrc/[0-9][0-9]_*.sh`
shs="$_x_sh_shs $zsh_shs"
for sh in $shs
do
  echo "loading $sh ..."
  echo ". $sh" >> "$HOME"/.zshrc
done

echo "##### end dotfiles #####" >> "$HOME"/.zshrc
