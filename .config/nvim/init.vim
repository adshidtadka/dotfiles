" Tiny vim
if 0 | endif

if &compatible
  set nocompatible
endif

let g:false = 0
let g:true = 1

augroup MyAutoCmd
  autocmd!
augroup END

function! Glob(from, pattern)
  return split(globpath(a:from, a:pattern), "[\r\n]")
endfunction

call plug#begin('~/.vim/plugged')

Plug 'andymass/vim-matchup'
let g:loaded_matchit = 1
Plug 'jonathanfilip/vim-lucius'
Plug 'w0ng/vim-hybrid'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/vim-easy-align'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/conflict-marker.vim'
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-z>'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tsandall/vim-rego'
Plug 'rhysd/vim-wasm'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lambdalisue/fern.vim'
nnoremap <C-y>t  :Fern . -reveal=% -drawer -keep<CR>
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
let g:fern#renderer = "nerdfont"
Plug 'lambdalisue/fern-git-status.vim'
let g:fern_git_status#disable_ignored = 1
" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive' | Plug 'junegunn/fzf', { 'do': './install --all' } | Plug 'junegunn/fzf.vim'
nnoremap <C-k>f :<C-u>GFiles<CR>
nnoremap <C-k>rg :<C-u>RipGrep<CR>
nnoremap <C-k>rd :<C-u>RipGrepDistinct<CR>
nnoremap <C-k>gs :<C-u>Gstatus<CR>
nnoremap <C-k>gd :<C-u>Gdiff<CR>
nnoremap <C-k>gb :<C-u>Gblame<CR>
nnoremap <C-k>gl :<C-u>Glog<CR>
command! -bang -nargs=* RipGrep
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --hidden --color=always '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:wrap'))
command! -bang -nargs=* RipGrepDistinct
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --hidden --color=always -i '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:wrap'))
command! -bang -nargs=? GFiles
      \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:60%:wrap'))
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
Plug 'Yggdroot/indentLine'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
let g:Hexokinase_highlighters = [ 'foreground' ]
set termguicolors
Plug 'easymotion/vim-easymotion'
Plug 'djoshea/vim-autoread'
Plug 'c9s/hypergit.vim'
Plug 'hashivim/vim-terraform'
let g:terraform_fmt_on_save = 1
Plug 'kamykn/spelunker.vim'
Plug 'jparise/vim-graphql'
Plug 'lambdalisue/gina.vim'
Plug 'github/copilot.vim'
Plug 'dart-lang/dart-vim-plugin'
let g:dart_format_on_save = 1
Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}

call plug#end()

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes


let g:dotvim = fnamemodify(resolve(expand('<sfile>:p')), ':h')
for script in Glob(g:dotvim."/scripts", "*[0-9]*_*.vim")
  execute 'source' escape(script, ' ')
endfor

" Must be written at the last.  see :help 'secure'.
set secure
