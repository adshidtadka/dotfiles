#!/bin/sh

# basic
alias ls='exa --icons'
alias ll='ls -lh'
alias la='ls -lah'
alias lt='ls -lah --tree'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# dotfiles
alias dotfiles="cd $DOTPATH"
alias srcrc="if [ -e ~/.${SHELL##*/}rc ]; then . ~/.${SHELL##*/}rc; fi"

# emacs
alias emacs='emacs -nw'

# gcc
alias g++14='g++ -std=c++14 -Wall'

# ruby, rails
alias be='bundle exec'
alias rsb='bundle exec rails s -b 0.0.0.0'
alias rtcc='bundle exec rake tmp:cache:clear'
alias Prc='bundle exec rails c -e production'
alias Prap='RAILS_ENV=production bundle exec rake assets:precompile assets:clean'
alias Prsb='bundle exec rails s -b 0.0.0.0 -e production'

# git
## status
alias gst="git status"
## branch
alias gbr="git branch"
## log graph
alias ggr="git gr"
## log graph long<
alias ggrl="git log --graph --pretty=oneline"
## clear unused branches
alias gbrcl="git branch --merged | grep -v '*' | xargs git branch -d"
## reset modes of the files
alias gprst="git diff --numstat | awk '{if ((\$1 == \"0\" && \$2 == \"0\") || (\$1 == \"-\" && \$2 == \"-\")) print \$3}' | xargs git checkout HEAD"
## word-by-word diff
alias gdfw="git dfw"
alias gshw="git shw"
## ghq list
alias gl='cd $(ghq root)/$(ghq list | peco)'
## hub browse
alias gb='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'

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

# linux
alias osstats='cat /etc/redhat-release /proc/version /proc/cpuinfo /proc/meminfo && echo "\n=====\n" && lscpu && echo "\n=====\n" && df -h'

# local IP address 確認
alias localips="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*'"

# redis
alias rds='redis-server'
alias rdc='redis-cli'

# npm
alias nrbw='npm run build:watch'
alias wpbw='$(npm bin)/webpack --progress --colors --watch'

# tail
alias tlf='tail -F'

# heroku
alias hlt='heroku logs -t'

# nkf
alias nuo='nkf -Luw --overwrite'

# python
alias jnb='jupyter notebook'

# fasd
eval "$(fasd --init auto)"
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
