" Netrw - Vim's built-in file browser.

" Open files and toggle folders with 'o' like in QuickFix.
autocmd FileType netrw map <silent> <buffer> o <CR>

" Errors should not open new splits. Use normal error handling, `:messages`.
let g:netrw_use_errorwindow = 0

" Use tree-style browsing by default
" 0 = normal, 1 = details, 2 = ls, 3 = tree
let g:netrw_liststyle = 3


" CtrlP - Fuzzy Finder in Vimscript

"let g:ctrlp_map = '<Leader>p'

" Use `ag` as fallback if available.
if executable('ag')
  let s:fallback = 'ag %s -l --nocolor -g ""'
else
  let s:fallback = 'find %s -type f'
endif

let g:ctrlp_user_command = [
  \ '.git',
  \ 'cd %s && git ls-files . -co --exclude-standard',
  \ s:fallback
\]

let g:ctrlp_extensions = ['funky']

" Function definition jumping with CtrlP's Funky plugin.
map <silent> <Leader>f :CtrlPFunky<CR>


" FZF - Fuzzy Finder in Go/Ruby

map <silent> <Leader>p :FZF<CR>
