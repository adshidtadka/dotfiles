#!/bin/sh

# zplug
#!/bin/sh

if command_exists sw_vers ; then
    export ZPLUG_HOME=/usr/local/opt/zplug
else
    export ZPLUG_HOME="$HOME"/.zplug/zplug
fi
source $ZPLUG_HOME/init.zsh
