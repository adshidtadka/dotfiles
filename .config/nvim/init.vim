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

call plug#begin('~/.local/share/nvim/plugged')

Plug 'andymass/vim-matchup'
let g:loaded_matchit = 1
Plug 'w0ng/vim-hybrid'
Plug 'rebelot/kanagawa.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/vim-easy-align'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/conflict-marker.vim'
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-z>'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neovim/nvim-lspconfig'
Plug 'saghen/blink.cmp', { 'tag': 'v1.*', 'do': 'cargo build --release' }
Plug 'tsandall/vim-rego'
Plug 'udalov/kotlin-vim'
Plug 'rhysd/vim-wasm'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lambdalisue/fern.vim'
nnoremap <C-y>t  :Fern . -reveal=% -drawer -keep<CR>
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
let g:fern#renderer = "nerdfont"
Plug 'lambdalisue/fern-git-status.vim'
let g:fern_git_status#disable_ignored = 1
Plug 'junegunn/fzf', { 'do': './install --all' } | Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '~90%' }
nnoremap <C-k>f :<C-u>GFiles<CR>
nnoremap <C-k>rg :<C-u>RipGrep<CR>
nnoremap <C-k>rd :<C-u>RipGrepDistinct<CR>
command! -bang -nargs=* RipGrep
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --hidden --no-ignore-vcs --ignore-file ~/.ignore --glob "!.git" --max-columns=200 --max-columns-preview --color=always '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'down:60%:wrap'))
command! -bang -nargs=* RipGrepDistinct
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --hidden --no-ignore-vcs --ignore-file ~/.ignore --glob "!.git" --max-columns=200 --max-columns-preview --color=always -i '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'down:60%:wrap'))
command! -bang -nargs=? GFiles
      \ call fzf#vim#files(<q-args>,
      \   fzf#vim#with_preview({'source': 'rg --files --hidden --no-ignore-vcs --ignore-file ~/.ignore --glob "!.git"'}, 'down:60%:wrap'))
Plug 'vim-denops/denops.vim'
Plug 'lambdalisue/vim-gin'
nnoremap <C-k>gs :<C-u>GinStatus<CR>
nnoremap <C-k>gd :<C-u>GinDiff<CR>
nnoremap <C-k>gl :<C-u>GinLog<CR>
nnoremap <C-k>gb :<C-u>GinBranch<CR>
nnoremap <C-g> :<C-u>GinBrowse<CR>
vnoremap <C-g> :GinBrowse<CR>
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
Plug 'hashivim/vim-terraform'
let g:terraform_fmt_on_save = 1
Plug 'kamykn/spelunker.vim'
Plug 'jparise/vim-graphql'
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'olimorris/codecompanion.nvim'
Plug 'dart-lang/dart-vim-plugin'
let g:dart_format_on_save = 1
Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}

call plug#end()

lua << EOF
require("codecompanion").setup({
  interactions = {
    chat = { adapter = "copilot" },
    inline = { adapter = "copilot" },
  },
})
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
vim.cmd([[cab cc CodeCompanion]])
EOF

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
