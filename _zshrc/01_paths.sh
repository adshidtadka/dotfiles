#!/bin/sh

# zplug
#!/bin/sh

if command_exists sw_vers ; then
    export ZPLUG_HOME=/opt/homebrew/opt/zplug
else
    export ZPLUG_HOME="$HOME"/.zplug
fi
source $ZPLUG_HOME/init.zsh
