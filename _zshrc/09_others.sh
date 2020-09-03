#!/bin/sh

# 補完時に濁点・半濁点を <3099> <309a> のように表示させない
setopt combining_chars

# curl で no matches found と怒られるのを防ぐ
alias curl='noglob curl'

function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection
