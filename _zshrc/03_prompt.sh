#!/bin/sh

# complement
autoload -Uz compinit && compinit

# 通常補完 -> （小文字 -> 大文字） -> （小文字 -> 大文字 + 大文字 -> 小文字)
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

# 色を使用出来るようにする
autoload -Uz colors
colors

# 2行表示
PROMPT="%{${fg[$zshrc_prompt_color]}%}%n@%M:%{${reset_color}%}%~
%{%(?.$fg[white].$fg[red])%}%#%{$reset_color%} "
