" Colour Scheme & Status Line
"
" Available colour schemes:
" - flattened_dark
" - neonwave

" Fix wrong background colour in tmux.
" http://sunaku.github.io/vim-256color-bce.html
set t_ut=

" Status line defaults.
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
set laststatus=2 " always show the status line.
set noshowmode   " hide modes e.g. --INSERT-- with themed status lines.

" Colour scheme defaults.
set background=dark
colorscheme flattened_dark
" fix sign column colour in flattened_dark (for vim-signature, syntastic).
highlight SignColumn ctermbg=235

function! NormalPower()
  set background=dark
  colorscheme flattened_dark
  AirlineTheme powerlineish
  highlight SignColumn ctermbg=235
  call MuteSpellCheckHighlights()
  echo "System at normal power..."
endfunction

function! UltraPower()
  set background=dark
  colorscheme neonwave
  AirlineTheme surarken
  call MuteSpellCheckHighlights()
  echo "Ultra Power Level Activated!"
endfunction

function! MuteSpellCheckHighlights()
  hi clear SpellBad
  hi SpellBad cterm=underline
  " Highlights must be cleared first, or linking will fail.
  hi clear SpellCap
  hi link SpellCap SpellBad
  hi clear SpellLocal
  hi link SpellLocal SpellBad
  hi clear SpellRare
  hi link SpellRare SpellBad
endfunction
call MuteSpellCheckHighlights()
