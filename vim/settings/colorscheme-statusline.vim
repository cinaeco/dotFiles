" Colour Scheme & Status Line
"
" Available colour schemes:
" - solarized
" - neonwave
" - alduin

" Fix wrong background colour in tmux, when using 256 colours, and when vim
" changes the background colour. http://sunaku.github.io/vim-256color-bce.html
set t_ut=

" The colour command that was last run.
let g:current_colour = expand('~/dotfiles/vim/current-colour')

" Status line defaults.
let g:airline#extensions#wordcount#filetypes = '\vhelp|markdown|rst|org|pandoc'
set noshowmode   " hide modes e.g. --INSERT-- with themed status lines.

" Toggle colour schemes.
command! Dark set background=light
      \| colorscheme neonwave
      \| call StatusTheme('surarken')
      \| call writefile(['Dark'], g:current_colour)

command! Light set background=light
      \| colorscheme vanilla-cake
      \| call StatusTheme('papercolor')
      \| call writefile(['Light'], g:current_colour)

function! StatusTheme(name)
  " Airline functions are not available at vim start.
  if exists(':AirlineTheme')
    execute 'AirlineTheme' a:name
  else
    let g:airline_theme = a:name
  endif
endfunction

" General colour scheme overrides.
autocmd ColorScheme * call CustomHighlights()
function! CustomHighlights()
  " Mute spellcheck highlighting.
  " Highlights must be cleared first, or `link` will fail.
  highlight clear SpellBad   | highlight SpellBad cterm=underline
  highlight clear SpellCap   | highlight link SpellCap SpellBad
  highlight clear SpellLocal | highlight link SpellLocal SpellBad
  highlight clear SpellRare  | highlight link SpellRare SpellBad
endfunction

" Use the last chosen colour scheme or default to a dark colorscheme.
if filereadable(expand(g:current_colour))
  execute 'source' g:current_colour
else
  Dark
endif
