if !exists('g:env')
  finish
endif


syntax enable on
set number

if g:env.is_gui
  set background=light
else
  set background=dark
endif

set t_Co=256
colorscheme kanagawa
syntax on

" StatusLine {{{1
set laststatus=2

lua << LUALINE
local pr_cache = { value = "", last_check = 0, last_dir = "" }

local function get_pr_number()
  local buf_dir = vim.fn.expand("%:p:h")
  if buf_dir == "" then buf_dir = vim.fn.getcwd() end
  local now = os.time()
  if now - pr_cache.last_check < 30 and pr_cache.last_dir == buf_dir then
    return pr_cache.value
  end
  pr_cache.last_check = now
  pr_cache.last_dir = buf_dir
  vim.fn.jobstart({ "gh", "pr", "view", "--json", "number", "-q", ".number" }, {
    cwd = buf_dir,
    stdout_buffered = true,
    on_stdout = function(_, data)
      local num = (data and data[1] or ""):match("^%d+$")
      pr_cache.value = num and ("\u{f407} #" .. num) or ""
    end,
    on_exit = function(_, code)
      if code ~= 0 then pr_cache.value = "" end
    end,
  })
  return pr_cache.value
end

local function selection_charcount()
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    return ""
  end
  local vpos = vim.fn.getpos("v")
  local cpos = vim.fn.getpos(".")
  local l1, c1 = vpos[2], vpos[3]
  local l2, c2 = cpos[2], cpos[3]
  if l1 > l2 or (l1 == l2 and c1 > c2) then
    l1, c1, l2, c2 = l2, c2, l1, c1
  end
  local chars = 0
  for lnum = l1, l2 do
    local line = vim.fn.getline(lnum)
    if mode == "V" then
      chars = chars + vim.fn.strchars(line)
    elseif mode == "\22" then
      chars = chars + vim.fn.strchars(string.sub(line, c1, c2))
    elseif l1 == l2 then
      chars = chars + vim.fn.strchars(string.sub(line, c1, c2))
    elseif lnum == l1 then
      chars = chars + vim.fn.strchars(string.sub(line, c1))
    elseif lnum == l2 then
      chars = chars + vim.fn.strchars(string.sub(line, 1, c2))
    else
      chars = chars + vim.fn.strchars(line)
    end
  end
  return chars .. " chars"
end

require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = "",
    component_separators = "|",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "branch", separator = "" }, { get_pr_number, separator = "" }, "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { selection_charcount, "filetype" },
    lualine_y = { "location" },
    lualine_z = { "progress" },
  },
})
LUALINE

" Tabpages {{{1
set showtabline=2
set tabline=%!MakeTabLine()

function! s:tabpage_label(n) "{{{3
  let n = a:n
  let bufnrs = tabpagebuflist(n)
  let curbufnr = bufnrs[tabpagewinnr(n) - 1]

  let hi = n == tabpagenr() ? 'TabLineSel' : 'TabLine'

  let label = ''
  let no = len(bufnrs)
  if no == 1
    let no = ''
  endif
  let mod = len(filter(bufnrs, 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let sp = (no . mod) ==# '' ? '' : ' '
  let fname = GetBufname(curbufnr, 's')

  if no !=# ''
    let label .= '%#' . hi . 'Number#' . no
  endif
  let label .= '%#' . hi . '#'
  let label .= fname . sp . mod

  return '%' . a:n . 'T' . label . '%T%#TabLineFill#'
endfunction

function! MakeTabLine() "{{{3
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' | '
  let tabs = join(titles, sep) . sep . '%#TabLineFill#%T'

  "hi TabLineFill ctermfg=white
  let info = '%#TabLineFill#'
  let info .= fnamemodify(getcwd(), ':~') . ' '
  return tabs . '%=' . info
endfunction


" Cursor line/column {{{1
set cursorline
augroup auto-cursorcolumn-appear
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorcolumn('CursorMoved')
  autocmd CursorHold,CursorHoldI   * call s:auto_cursorcolumn('CursorHold')
  autocmd BufEnter * call s:auto_cursorcolumn('WinEnter')
  autocmd BufLeave * call s:auto_cursorcolumn('WinLeave')

  let s:cursorcolumn_lock = 0
  function! s:auto_cursorcolumn(event)
    if a:event ==# 'WinEnter'
      setlocal cursorcolumn
      let s:cursorcolumn_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorcolumn
    elseif a:event ==# 'CursorMoved'
      setlocal nocursorcolumn
      if s:cursorcolumn_lock
        if 1 < s:cursorcolumn_lock
          let s:cursorcolumn_lock = 1
        else
          setlocal nocursorcolumn
          let s:cursorcolumn_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorcolumn
      let s:cursorcolumn_lock = 1
    endif
  endfunction
augroup END

augroup multi-window-toggle-cursor "{{{1
  autocmd!
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline nocursorcolumn
augroup END 

augroup cursor-highlight-emphasis "{{{1
  autocmd!
  autocmd CursorMoved,CursorMovedI,WinLeave * hi! link CursorLine CursorLine | hi! link CursorColumn CursorColumn
  autocmd CursorHold,CursorHoldI            * hi! link CursorLine Visual     | hi! link CursorColumn Visual
augroup END

" ZEN-KAKU
" Display zenkaku-space {{{1
augroup hilight-idegraphic-space
  autocmd!
  "autocmd VimEnter,ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  "autocmd WinEnter * match IdeographicSpace /　/
  autocmd VimEnter,ColorScheme * call <SID>hl_trailing_spaces()
  autocmd VimEnter,ColorScheme * call <SID>hl_zenkaku_space()
augroup END

function! s:hl_trailing_spaces()
  highlight! link TrailingSpaces Error
  syntax match TrailingSpaces containedin=ALL /\s\+$/
endfunction

function! s:hl_zenkaku_space()
  highlight! link ZenkakuSpace Error
  syntax match ZenkakuSpace containedin=ALL /　/
endfunction

" __END__ {{{1
" vim:fdm=marker expandtab fdc=3:

