" Legacy Vim entrypoint.
" Keep this file for backward compatibility and delegate to ~/.vimrc.
if filereadable(expand('~/.vimrc'))
  execute 'source' fnameescape(expand('~/.vimrc'))
endif
