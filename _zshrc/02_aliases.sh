#!/bin/sh

# Style
zstyle -s ':prezto:module:git:log:medium' format '_git_log_medium_format' \
  || _git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
zstyle -s ':prezto:module:git:log:oneline' format '_git_log_oneline_format' \
  || _git_log_oneline_format='%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n'
zstyle -s ':prezto:module:git:log:brief' format '_git_log_brief_format' \
  || _git_log_brief_format='%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n'

# Log (l)
alias gll='git log --topo-order --pretty=format:"${_git_log_medium_format}"'
alias gls='git log --topo-order --stat --pretty=format:"${_git_log_medium_format}"'
alias gld='git log --topo-order --stat --patch --full-diff --pretty=format:"${_git_log_medium_format}"'
alias glo='git log --topo-order --pretty=format:"${_git_log_oneline_format}"'
alias glg='git log --topo-order --all --graph --pretty=format:"${_git_log_oneline_format}"'
alias glb='git log --topo-order --pretty=format:"${_git_log_brief_format}"'

# exa
if command_exists exa ; then
  alias ls='exa --icons'
fi
alias ll='ls -lh'
alias la='ls -lah'
alias lt='ls -lah --tree'

# fasd
if command_exists fasd ; then
  eval "$(fasd --init auto)"
  alias a='fasd -a'        # any
  alias s='fasd -si'       # show / search / select
  alias d='fasd -d'        # directory
  alias f='fasd -f'        # file
  alias sd='fasd -sid'     # interactive directory selection
  alias sf='fasd -sif'     # interactive file selection
  alias z='fasd_cd -d'     # cd, same functionality as j in autojump
  alias zz='fasd_cd -d -i' # cd with interactive selection
fi

# ディレクトリ移動
function peco-fasd() {
    DESTINATION=`fasd -ld | peco --query "$LBUFFER" --prompt "DIRECTORY>"`
    BUFFER="cd $DESTINATION"
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-fasd
bindkey '^W^W' peco-fasd

# 履歴のインクリメンタルサーチ
function peco-history() {
    local tac
    type tac &> /dev/null \
        && tac="tac" \
        || tac="tail -r"
    BUFFER=$(history -n 1 | eval $tac | peco --query "$LBUFFER" --prompt "HISTORY>")
    CURSOR=$#BUFFER
}
zle -N peco-history
bindkey '^W^H' peco-history

# ghqによるリポジトリ一覧&移動
function peco-src() {
    local selected_dir=$(ghq list --full-path | sort | peco --query "$LBUFFER" --prompt "GHQ>")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^W^G' peco-src

# ブランチ選択
function peco-branch() {
    local branch=$(git branch | peco --prompt "BRANCH>" | tr -d ' ' | tr -d '*' | awk '{print $0}' ORS=' ')
    if [ -n "$branch" ]; then
      if [ -n "$LBUFFER" ]; then
        local new_left="${LBUFFER%\ } $branch"
      else
        local new_left="$branch"
      fi
      BUFFER=${new_left}${RBUFFER}
      CURSOR=${#new_left}
    fi
}
zle -N peco-branch
bindkey '^W^B' peco-branch

# AWS
peco-aws-profile() {
    local profile=$(aws configure list-profiles | sort | peco --prompt 'AWS PROFILE>' | tr '\n' ' ')
    [ -z $profile ] && return
    BUFFER="$LBUFFER$profile$RBUFFER"
    CURSOR=$#BUFFER
}
zle -N peco-aws-profile
bindkey '^W^A' peco-aws-profile

funcion awslogin() {
    aws sso login --profile $(aws configure list-profiles | sort | peco --select-1 --prompt 'AWS PROFILE>')
}

# ctrlを有効にする
bindkey -e
