#!/bin/bash

set -e

DOTPATH="$HOME/dotfiles"
export DOTPATH

cd $DOTPATH


echo
for dotfile in .??*; do
  [ "$dotfile" = ".git" ] && continue
  [ "$dotfile" = ".gitignore" ] && continue
  [ "$dotfile" = ".gitattributes" ] && continue
  [ "$dotfile" = ".DS_Store" ] && continue
  [ ${dotfile##*.} = "swp" ] && continue

  echo

  if [ "$dotfile" = ".config" ]; then
    for cfg in `ls .config`; do
      if [ -e "$HOME"/".config"/"$cfg" ]; then
        if [ -d "$DOTPATH"/".config"/"$cfg" ]; then
          rm -rf "$HOME"/".config"/"$cfg"
        fi
      fi
      echo "loading .config/$cfg ..."
      ln -snfv "$DOTPATH"/".config"/"$cfg" "$HOME"/".config"
    done
    continue
  fi

  if [ -e "$HOME"/"$dotfile" ]; then
    if [ -d "$DOTPATH"/"$dotfile" ]; then
      rm -rf "$HOME"/"$dotfile"
    fi
  fi
  echo "loading $dotfile ..."
  ln -snfv "$DOTPATH"/"$dotfile" "$HOME"
done

select_theme_color () {
  if [ ! $theme_color ] ; then
    export theme_color='green'
  fi
  echo "Select theme color from below. Default is '$theme_color'."
  echo "  [black, red, green, yellow, blue, magenta, cyan, white]"
  /bin/echo -n "theme color > "
  read tmp_theme_color
  if [ $tmp_theme_color ] ; then
    export theme_color=$tmp_theme_color
  fi
  echo "theme_color = $theme_color"
}

select_theme_color

echo
echo "loading .zshrc ..."
./_zshrc/deploy.sh
echo

echo "loading AGENTS.md ..."
ln -snfv "$DOTPATH"/AGENTS.md "$HOME"/.claude/CLAUDE.md
ln -snfv "$DOTPATH"/AGENTS.md "$HOME"/.codex/instructions.md
mkdir -p "$HOME"/.cursor/rules
ln -snfv "$DOTPATH"/AGENTS.md "$HOME"/.cursor/rules/global.mdc
echo

echo "configuring git ..."
if command -v git >/dev/null 2>&1 ; then
  if [ "`git remote -v | grep https`" ]; then
    new_origin='https://github.com/adshidtadka/dotfiles.git'
  else
    new_origin='git@github.com:adshidtadka/dotfiles.git'
  fi
  set -x
  git remote set-url origin $new_origin
  { set +x; } 2>/dev/null

  git config --global core.editor 'nvim'
  git config --global core.excludesfile ~/.gitignore_global
  git config --global color.ui true
  git config --global color.diff auto
  git config --global color.status auto
  git config --global color.branch auto
  git config --global push.default current
  git config --global fetch.prune true
  git config feature.manyFiles true
fi

echo
echo "finished."

