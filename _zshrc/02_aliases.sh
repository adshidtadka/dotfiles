#!/bin/sh

# Git
alias g='git'

# Branch (b)
alias gb='git branch'
alias gba='git branch --all --verbose'
alias gbc='git checkout -b'
alias gbd='git branch --delete'
alias gbD='git branch -D'
alias gbl='git branch --verbose'
alias gbL='git branch --all --verbose'
alias gbm='git branch --move'
alias gbM='git branch --move --force'
alias gbr='git branch --move'
alias gbR='git branch --move --force'
alias gbs='git show-branch'
alias gbS='git show-branch --all'
alias gbv='git branch --verbose'
alias gbV='git branch --verbose --verbose'
alias gbx='git branch --delete'
alias gbX='git branch -D'
alias gbsu='git branch --set-upstream-to=origin/$(git rev-parse --abbrev-ref HEAD) $(git rev-parse --abbrev-ref HEAD)'

# Commit (c)
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gcm='git commit --message'
alias gcS='git commit -S --verbose'
alias gcSa='git commit -S --verbose --all'
alias gcSm='git commit -S --message'
alias gcam='git commit --all --message'
alias gco='git checkout'
alias gcO='git checkout --patch'
alias gcod='git checkout --detach'
alias gcf='git commit --amend --reuse-message HEAD'
alias gcSf='git commit -S --amend --reuse-message HEAD'
alias gcF='git commit --verbose --amend'
alias gcSF='git commit -S --verbose --amend'
alias gcp='git cherry-pick --ff'
alias gcP='git cherry-pick --no-commit'
alias gcr='git revert'
alias gcR='git reset "HEAD^"'
alias gcs='git show'
alias gcsS='git show --pretty=short --show-signature'
alias gcl='git-commit-lost'
alias gcy='git cherry -v --abbrev'
alias gcY='git cherry -v'

# Conflict (C)
alias gCl='git --no-pager diff --name-only --diff-filter=U'
alias gCa='git add $(gCl)'
alias gCe='git mergetool $(gCl)'
alias gCo='git checkout --ours --'
alias gCO='gCo $(gCl)'
alias gCt='git checkout --theirs --'
alias gCT='gCt $(gCl)'

# Data (d)
alias gd='git ls-files'
alias gdc='git ls-files --cached'
alias gdx='git ls-files --deleted'
alias gdm='git ls-files --modified'
alias gdu='git ls-files --other --exclude-standard'
alias gdk='git ls-files --killed'
alias gdi='git status --porcelain --short --ignored | sed -n "s/^!! //p"'

# Fetch (f)
alias gf='git fetch'
alias gfa='git fetch --all'
alias gfc='git clone'
alias gfcr='git clone --recurse-submodules'
alias gfm='git pull'
alias gfr='git pull --rebase'

# Flow (F)
alias gFi='git flow init'
alias gFf='git flow feature'
alias gFb='git flow bugfix'
alias gFl='git flow release'
alias gFh='git flow hotfix'
alias gFs='git flow support'

alias gFfl='git flow feature list'
alias gFfs='git flow feature start'
alias gFff='git flow feature finish'
alias gFfp='git flow feature publish'
alias gFft='git flow feature track'
alias gFfd='git flow feature diff'
alias gFfr='git flow feature rebase'
alias gFfc='git flow feature checkout'
alias gFfm='git flow feature pull'
alias gFfx='git flow feature delete'

alias gFbl='git flow bugfix list'
alias gFbs='git flow bugfix start'
alias gFbf='git flow bugfix finish'
alias gFbp='git flow bugfix publish'
alias gFbt='git flow bugfix track'
alias gFbd='git flow bugfix diff'
alias gFbr='git flow bugfix rebase'
alias gFbc='git flow bugfix checkout'
alias gFbm='git flow bugfix pull'
alias gFbx='git flow bugfix delete'

alias gFll='git flow release list'
alias gFls='git flow release start'
alias gFlf='git flow release finish'
alias gFlp='git flow release publish'
alias gFlt='git flow release track'
alias gFld='git flow release diff'
alias gFlr='git flow release rebase'
alias gFlc='git flow release checkout'
alias gFlm='git flow release pull'
alias gFlx='git flow release delete'

alias gFhl='git flow hotfix list'
alias gFhs='git flow hotfix start'
alias gFhf='git flow hotfix finish'
alias gFhp='git flow hotfix publish'
alias gFht='git flow hotfix track'
alias gFhd='git flow hotfix diff'
alias gFhr='git flow hotfix rebase'
alias gFhc='git flow hotfix checkout'
alias gFhm='git flow hotfix pull'
alias gFhx='git flow hotfix delete'

alias gFsl='git flow support list'
alias gFss='git flow support start'
alias gFsf='git flow support finish'
alias gFsp='git flow support publish'
alias gFst='git flow support track'
alias gFsd='git flow support diff'
alias gFsr='git flow support rebase'
alias gFsc='git flow support checkout'
alias gFsm='git flow support pull'
alias gFsx='git flow support delete'

# Grep (g)
alias gg='git grep'
alias ggi='git grep --ignore-case'
alias ggl='git grep --files-with-matches'
alias ggL='git grep --files-without-matches'
alias ggv='git grep --invert-match'
alias ggw='git grep --word-regexp'

# Index (i)
alias gia='git add'
alias giA='git add --patch'
alias giu='git add --update'
alias gid='git diff --no-ext-diff --cached'
alias giD='git diff --no-ext-diff --cached --word-diff'
alias gii='git update-index --assume-unchanged'
alias giI='git update-index --no-assume-unchanged'
alias gir='git reset'
alias giR='git reset --patch'
alias gix='git rm -r --cached'
alias giX='git rm -rf --cached'

# Log (l)
alias gl='git log --graph --oneline --decorate -10'
alias glc='git shortlog --summary --numbered'
alias glS='git log --show-signature'

# Merge (m)
alias gm='git merge'
alias gmC='git merge --no-commit'
alias gmF='git merge --no-ff'
alias gma='git merge --abort'
alias gmt='git mergetool'

# Push (p)
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpF='git push --force'
alias gpa='git push --all'
alias gpA='git push --all && git push --tags'
alias gpt='git push --tags'
alias gpc='git push --set-upstream origin "$(git-branch-current 2> /dev/null)"'
alias gpp='git pull origin "$(git-branch-current 2> /dev/null)" && git push origin "$(git-branch-current 2> /dev/null)"'

# Rebase (r)
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grs='git rebase --skip'

# Remote (R)
alias gR='git remote'
alias gRl='git remote --verbose'
alias gRa='git remote add'
alias gRx='git remote rm'
alias gRm='git remote rename'
alias gRu='git remote update'
alias gRp='git remote prune'
alias gRs='git remote show'
alias gRb='git-hub-browse'

# Stash (s)
alias gs='git stash'
alias gsa='git stash apply'
alias gsx='git stash drop'
alias gsX='git-stash-clear-interactive'
alias gsl='git stash list'
alias gsL='git-stash-dropped'
alias gsd='git stash show --patch --stat'
alias gsp='git stash pop'
alias gsr='git-stash-recover'
alias gss='git stash save --include-untracked'
alias gsS='git stash save --patch --no-keep-index'
alias gsw='git stash save --include-untracked --keep-index'

# Submodule (S)
alias gS='git submodule'
alias gSa='git submodule add'
alias gSf='git submodule foreach'
alias gSi='git submodule init'
alias gSI='git submodule update --init --recursive'
alias gSl='git submodule status'
alias gSm='git-submodule-move'
alias gSs='git submodule sync'
alias gSu='git submodule foreach git pull origin master'
alias gSx='git-submodule-remove'

# Tag (t)
alias gt='git tag'
alias gtl='git tag -l'
alias gts='git tag -s'
alias gtv='git verify-tag'

# Working Copy (w)
alias gwS='git status'
alias gwD='git diff --no-ext-diff --word-diff'
alias gwr='git reset --soft'
alias gwR='git reset --hard'
alias gwc='git clean -dn'
alias gwC='git clean -df'
alias gwx='git rm -r'
alias gwX='git rm -rf'

function gwd() {
  if [[ -x `which ydiff 2>/dev/null` ]]; then
    git diff $@ | ydiff -s -w 0
  else
    git diff $@
  fi
}

# svn
alias sst='svn st'
alias sdf='svn diff'
alias sadd="svn stat | grep -e '^?'  | awk '{ print $2 }' | xargs svn add"
alias sdel="svn stat | grep -e '^\!' | awk '{ print $2 }' | xargs svn del"
alias srev="svn stat | grep -e '^M'  | awk '{ print $2 }' | xargs svn revert"

# vagrant
alias vain='vagrant up && vagrant ssh'
alias vash='vagrant ssh'
alias vahl='vagrant halt'
alias vasus='vagrant suspend'
alias varein='vagrant reload && vagrant ssh'
alias vast='vagrant status'

# docker
alias dcm='docker-compose'

# local IP address
alias localips="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*'"

# redis
alias rds='redis-server'
alias rdc='redis-cli'

# tail
alias tlf='tail -F'

# heroku
alias hlt='heroku logs -t'

# nkf
alias nuo='nkf -Luw --overwrite'

# python
alias jnb='jupyter notebook'

# kubectl
alias k='kubectl'

# terraform
alias tf='terraform'

# pbcopy
alias pbc='pbcopy'


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

# zoxide
if command_exists zoxide ; then
  eval "$(zoxide init zsh)"
fi

# cd 時刻の記録
_CHPWD_LOG="$HOME/.local/share/zsh/chpwd.log"
[[ -d "${_CHPWD_LOG:h}" ]] || mkdir -p "${_CHPWD_LOG:h}"
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _log_chpwd
function _log_chpwd() { print -r "$(date '+%Y-%m-%d %H:%M:%S')	$PWD" >> "$_CHPWD_LOG" }

# ディレクトリ移動（zoxide + chpwd ログ + Cursor Agent のターミナル履歴）
function _collect_dir_timestamps() {
    [[ -f "$_CHPWD_LOG" ]] && tail -r "$_CHPWD_LOG"

    local base="$HOME/.cursor/projects"
    [[ -d "$base" ]] || return
    for f in "$base"/*/terminals/*.txt(N); do
        local cwd="" ts=""
        while IFS= read -r line; do
            case "$line" in
                cwd:*) cwd="${${line#cwd: }//\"/}" ;;
                started_at:*) ts="${line#started_at: }" ;;
            esac
            [[ "$line" == "---" && -n "$cwd" ]] && break
        done < "$f"
        [[ -n "$cwd" && -d "$cwd" ]] || continue
        if [[ -n "$ts" ]]; then
            echo "${ts%%.*}	${cwd}"
        else
            echo "	${cwd}"
        fi
    done
}

function peco-zoxide() {
    local destination
    if ! command_exists zoxide || ! command_exists peco ; then
        zle -M "zoxide or peco is not installed."
        return
    fi

    local cols=${COLUMNS:-$(tput cols)}
    destination=$(
        _collect_dir_timestamps \
          | awk -F'\t' '$2 != "" && !seen[$2]++ {
                ts = $1
                if (match(ts, /T/)) {
                    split(substr(ts,1,10), d, "-"); split(substr(ts,12), t, ":")
                    h = t[1] + 9; day = d[3] + 0
                    if (h >= 24) { h -= 24; day++ }
                    ts = sprintf("%s-%s-%02d %02d:%s:%s", d[1], d[2], day, h, t[2], t[3])
                }
                if (ts != "") times[$2] = "[" ts "]"
            }
            END { for (k in times) print k "\t" times[k] }' \
          | { declare -A ts_map
              while IFS=$'\t' read -r dir stamp; do
                  [[ -n "$stamp" ]] && ts_map[$dir]="$stamp"
              done
              zoxide query -l 2>/dev/null | while IFS= read -r dir; do
                  [[ -n "${ts_map[$dir]}" ]] && printf '%s\t%s\n' "$dir" "${ts_map[$dir]}" && unset "ts_map[$dir]" || echo "$dir"
              done
              for dir in "${(@k)ts_map}"; do printf '%s\t%s\n' "$dir" "${ts_map[$dir]}"; done
          } \
          | awk -F'\t' -v cols="$cols" 'NF==2 {
                pad=cols-length($1)-length($2)-1; if(pad<2) pad=2
                printf "%s%"pad"s%s\n",$1," ",$2; next
            } { print }' \
          | peco --query "$LBUFFER" --prompt "DIRECTORY>"
    )

    destination=$(echo "$destination" | sed 's/  *\[.*\]$//')
    if [ -n "$destination" ]; then
        BUFFER="cd ${(q)destination}"
        CURSOR=$#BUFFER
        zle reset-prompt
    else
        zle -M "No match. Add history by moving around with cd/z first."
    fi
}
zle -N peco-zoxide
bindkey '^W^W' peco-zoxide

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
      BUFFER="git checkout ${new_left}${RBUFFER}"
      CURSOR=${#RBUFFER}
    fi
}
zle -N peco-branch
bindkey '^W^B' peco-branch

# AWS
function peco-aws-profile() {
    local profile=$(aws configure list-profiles | sort | peco --prompt 'AWS PROFILE>' | tr '\n' ' ')
    [ -z $profile ] && return
    BUFFER="$LBUFFER$profile$RBUFFER"
    CURSOR=$#BUFFER
}
zle -N peco-aws-profile
bindkey '^W^A' peco-aws-profile

function awslogin() {
    aws sso login --profile $(aws configure list-profiles | sort | peco --select-1 --prompt 'AWS PROFILE>')
}

# ctrlを有効にする
bindkey -e
