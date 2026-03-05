" Delegate all settings to Neovim config when Vim can load it.
" Keep plain Vim startup safe for sudo/difftool-like use.
if exists('$SUDO_USER')
  finish
endif

if !filereadable(expand('~/.vim/autoload/plug.vim'))
  finish
endif

if filereadable(expand('~/.config/nvim/init.vim'))
  execute 'source' fnameescape(expand('~/.config/nvim/init.vim'))
endif
