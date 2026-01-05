function! s:vimrc_environment()
    let env = {}
    let env.is_ = {}
    let env.is_.windows = has('win16') || has('win32') || has('win64')
    let env.is_.cygwin = has('win32unix')
    
    " system()呼び出しを削除 - has()だけで判定
    let env.is_.mac = has('mac') || has('macunix') || has('gui_macvim')
    let env.is_.linux = !env.is_.mac && !env.is_.windows && !env.is_.cygwin && has('unix')
    
    let env.is_starting = has('vim_starting')
    let env.is_gui      = has('gui_running')
    let env.hostname    = substitute(hostname(), '[^\w.]', '', '')
    
    " vim
    if env.is_.windows
        let vimpath = expand('~/vimfiles')
    else
        let vimpath = expand(g:dotvim)
    endif
    let env.path = {
                \ 'vim': vimpath,
                \ }
    
    " executable()は高速なのでそのまま
    let env.bin = {
                \ 'ag': executable('ag'),
                \ 'osascript': executable('osascript'),
                \ 'open': executable('open'),
                \ 'chmod': executable('chmod'),
                \ 'qlmanage': executable('qlmanage'),
                \ }
    
    " tmux - 遅延評価に変更（使用時のみ取得）
    let env.is_tmux_running = !empty($TMUX)
    " この行をコメントアウト
    " let env.tmux_proc = system('tmux display-message -p "#W"')
    
    let env.vimrc = {
                \ 'plugin_on': g:false,
                \ 'suggest_neobundleinit': g:false,
                \ 'goback_to_eof2bof': g:false,
                \ 'save_window_position': g:true,
                \ 'restore_cursor_position': g:true,
                \ 'statusline_manually': g:false,
                \ 'add_execute_perm': g:false,
                \ 'colorize_statusline_insert': g:true,
                \ 'manage_rtp_manually': g:true,
                \ 'auto_cd_file_parentdir': g:true,
                \ 'ignore_all_settings': g:true,
                \ 'check_plug_update': g:false,
                \ }
    return env
endfunction

" tmux_procが必要な場合のみ取得する関数を追加
function! GetTmuxProc()
    if !exists('g:env.tmux_proc')
        let g:env.tmux_proc = system('tmux display-message -p "#W"')
    endif
    return g:env.tmux_proc
endfunction

let g:env = s:vimrc_environment()
function! IsWindows() abort
    return g:env.is_.windows
endfunction
function! IsMac() abort
    return g:env.is_.mac
endfunction
