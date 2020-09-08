#!/bin/sh

# complement
autoload -Uz compinit && compinit

# 色を使用出来るようにする
autoload -Uz colors && colors

# バージョン管理システムの情報を取得
autoload -Uz vcs_info

# hook関数を使えるようにする
autoload -Uz add-zsh-hook

# 通常補完 -> （小文字 -> 大文字） -> （小文字 -> 大文字 + 大文字 -> 小文字)
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

# formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' check-for-changes true

# commit されていないファイルがある
zstyle ':vcs_info:git:*' stagedstr "%F{cyan}!"

# add されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+"
#
# フォーマットの設定
zstyle ':vcs_info:*' formats "%F{$zshrc_prompt_color}%c%u%b%f"

# アクションが必要な状態でのフォーマット
zstyle ':vcs_info:*' actionformats '%F{red}%b|%a%f'

# プロンプトが表示される毎にバージョン管理システムの情報を取得
add-zsh-hook precmd vcs_info

# プロンプトを表示する際に変数を展開する
setopt prompt_subst

# # プロンプトのフォーマット
PROMPT='%{${fg[$zshrc_prompt_color]}%}%n@%m:%{${reset_color}%}%~ %{${vcs_info_msg_0_}%}
%{%(?.$fg[white].$fg[red])%}%#%{$reset_color%} '
RPROMPT='%{${fg[$zshrc_prompt_color]}%}%*%{${reset_color}%}'
