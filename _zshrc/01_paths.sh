#!/bin/sh

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# zplug
if command_exists sw_vers ; then
    export ZPLUG_HOME=$(brew --prefix)/opt/zplug
else
    export ZPLUG_HOME="$HOME"/.zplug
fi
source $ZPLUG_HOME/init.zsh


