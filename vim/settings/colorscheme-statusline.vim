" Colour Scheme & Status Line
"
" Available colour schemes:
" - flattened (solarized clone)
" - neonwave

" Fix wrong background colour in tmux, when using 256 colours, and when vim
" changes the background colour.
" http://sunaku.github.io/vim-256color-bce.html
set t_ut=

" Uncomment this to use proper solarized colours, after the terminal emulator
" palette is properly set up.
"set t_Co=16

" Status line defaults.
let g:airline_powerline_fonts = 1
set laststatus=2 " always show the status line.
set noshowmode   " hide modes e.g. --INSERT-- with themed status lines.
set showcmd      " display partial commands on the last line

function! Dark()
  colorscheme flattened_dark
  call SetTheme('powerlineish')
  highlight SignColumn ctermbg=235
endfunction

function! Light()
  colorscheme flattened_light
  call SetTheme('powerlineish')
endfunction

function! Neon()
  colorscheme neonwave
  call SetTheme('surarken')
endfunction

function! SetTheme(name)
  " Airline functions are not available at vim start.
  if exists(':AirlineTheme')
    execute 'AirlineTheme' a:name
  else
    let g:airline_theme = a:name
  endif
endfunction

function! MuteSpellCheckHighlights()
  hi clear SpellBad   | hi SpellBad cterm=underline
  " Highlights must be cleared first, or linking will fail.
  hi clear SpellCap   | hi link SpellCap SpellBad
  hi clear SpellLocal | hi link SpellLocal SpellBad
  hi clear SpellRare  | hi link SpellRare SpellBad
endfunction

call Dark()
