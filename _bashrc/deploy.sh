#!/bin/sh

set -e

echo "deploying .bashrc ..."

cd $DOTPATH

echo "##### begin dotfiles #####" >> "$HOME"/.bashrc

_x_sh_shs=`ls $DOTPATH/_x_shrc/[0-9][0-9]_*.sh`
bash_shs=`ls $DOTPATH/_bashrc/[0-9][0-9]_*.sh`
shs="$_x_sh_shs $bash_shs"
for sh in $shs
do
  echo "loading $sh ..."
  echo ". $sh" >> "$HOME"/.bashrc
done

echo "##### end dotfiles #####" >> "$HOME"/.bashrc
