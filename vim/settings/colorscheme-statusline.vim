" Colour Scheme & Status Line
"
" Available colour schemes:
" - flattened (solarized clone)
" - neonwave

" Fix wrong background colour in tmux, when using 256 colours, and when vim
" changes the background colour.
" http://sunaku.github.io/vim-256color-bce.html
set t_ut=

" Comment this out to use proper solarized colours, after the terminal emulator
" palette is properly set up.
let g:solarized_termcolors=256

" Status line defaults.
let g:airline_powerline_fonts = 1
set laststatus=2 " always show the status line.
set noshowmode   " hide modes e.g. --INSERT-- with themed status lines.
set showcmd      " display partial commands on the last line

command! Dark set background=dark
      \| colorscheme solarized
      \| call SetTheme('powerlineish')
      \| highlight SignColumn ctermbg=235

command! Light set background=light
      \| colorscheme solarized
      \| call SetTheme('powerlineish')

command! Neon set background=light
      \| colorscheme neonwave
      \| call SetTheme('surarken')

function! SetTheme(name)
  " Airline functions are not available at vim start.
  if exists(':AirlineTheme')
    execute 'AirlineTheme' a:name
  else
    let g:airline_theme = a:name
  endif
endfunction

" General Colorscheme overrides
autocmd ColorScheme * call CustomHighlights()
function! CustomHighlights()
  highlight ExtraWhitespace ctermbg=red guibg=red
  " Mute spellcheck highlighting
  " Highlights must be cleared first, or `link` will fail.
  highlight clear SpellBad   | highlight SpellBad cterm=underline
  highlight clear SpellCap   | highlight link SpellCap SpellBad
  highlight clear SpellLocal | highlight link SpellLocal SpellBad
  highlight clear SpellRare  | highlight link SpellRare SpellBad
endfunction

" Set starting colorscheme
Dark
