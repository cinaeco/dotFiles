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
set laststatus=2 " always show the status line.
set noshowmode   " hide modes e.g. --INSERT-- with themed status lines.
set showcmd      " display partial commands on the last line

function! NormalPower()
  set background=dark
  colorscheme flattened_dark
  call SetTheme('powerlineish')
  call MuteSpellCheckHighlights()
  " fix sign column colour in flattened_dark (for vim-signature, syntastic).
  highlight SignColumn ctermbg=235
endfunction

function! UltraPower()
  set background=dark
  colorscheme neonwave
  call SetTheme('surarken')
  call MuteSpellCheckHighlights()
endfunction

function! SetTheme(name)
  " Airline functions are not available at vim start.
  if exists(':AirlineTheme')
    exec 'AirlineTheme' a:name
  else
    let g:airline_theme = a:name
  endif
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

call NormalPower()
