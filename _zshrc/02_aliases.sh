#!/bin/sh

# gcc
alias g++14='g++ -std=c++14 -Wall'

# ruby, rails
alias be='bundle exec'
alias rsb='rails s -b 0.0.0.0'

# git
alias gbrcl="git branch --merged | grep -v '*' | xargs git branch -d"

# vagrant
alias vain='vagrant up && vagrant ssh'
alias vash='vagrant ssh'
alias vahl='vagrant halt'
alias vasus='vagrant suspend'
alias varein='vagrant reload && vagrant ssh'

# local IP address 確認
alias localips="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*'"

# redis
alias rds='redis-server'
alias rdc='redis-cli'

# npm
alias nrbw='npm run build:watch'
alias wpbw='webpack --progress --colors --watch'

# tmux
alias txa='tmux a || tmux'

# tail
alias tlf='tail -f'

# heroku
alias hlt='heroku logs -t'

