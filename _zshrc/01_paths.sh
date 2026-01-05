#!/bin/sh

# compinit の高速化（1日1回だけフル実行、2回目以降はスキップ）
autoload -Uz compinit
_comp_path="${ZDOTDIR:-$HOME}/.zcompdump"

# 既に compinit が実行済みならスキップ
if [[ -z "$_comps_initialized" ]]; then
    if [[ -f "$_comp_path" ]]; then
        # キャッシュが1日以内なら高速モード (-C)
        if [[ $(find "$_comp_path" -mtime -1 2>/dev/null) ]]; then
            compinit -C -d "$_comp_path"
        else
            compinit -d "$_comp_path"
        fi
    else
        compinit -d "$_comp_path"
    fi
    _comps_initialized=1
fi
unset _comp_path

# compinit の再呼び出しを防ぐラッパー
compinit() {
    # 既に初期化済みの場合は何もしない
    :
}

