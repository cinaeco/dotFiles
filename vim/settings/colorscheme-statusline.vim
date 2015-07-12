""""""""
"" Colour Scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Fix wrong background colour in tmux.
" http://sunaku.github.io/vim-256color-bce.html
set t_ut=

" Available colour schemes:
"colorscheme flattened_dark  " Like solarized but easier.
"colorscheme neonwave

autocmd VimEnter * call NormalPower()

function! NormalPower()
  set background=dark
  colorscheme flattened_dark
  AirlineTheme powerlineish
  " Fix sign column colour (for vim-signature, syntastic).
  highlight SignColumn ctermbg=235
  call MuteSpellCheckHighlights()
  echo "System at normal power..."
endfunction

function! UltraPower()
  set background=light
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

""""""""
"" Status Line
""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2
set noshowmode " don't show e.g. --INSERT-- with themed status lines.

let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
