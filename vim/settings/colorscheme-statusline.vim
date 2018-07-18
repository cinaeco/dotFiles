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

" Mark if the proper solarized colour palette mode should be used.
let g:solarized_palette = expand('~/dotfiles/vim/use-solarized-palette')

" Status line defaults.
let g:airline#extensions#wordcount#filetypes = '\vhelp|markdown|rst|org|pandoc'
set noshowmode   " hide modes e.g. --INSERT-- with themed status lines.

" Toggle colour schemes.
command! Alduin let g:alduin_Contract_Vampirism = 1
      \| colorscheme alduin
      \| call StatusTheme('ubaryd')
      \| call writefile(['Alduin'], g:current_colour)

command! Dark set background=dark
      \| colorscheme solarized
      \| call StatusTheme('powerlineish')
      \| highlight SignColumn ctermbg=235
      \| call writefile(['Dark'], g:current_colour)

command! Light set background=light
      \| colorscheme solarized
      \| call StatusTheme('papercolor')
      \| call writefile(['Light'], g:current_colour)

command! Neon set background=light
      \| colorscheme neonwave
      \| call StatusTheme('surarken')
      \| call writefile(['Neon'], g:current_colour)

" Toggle Solarized Colour Palette Degradation.
command! SolarizedColourProper execute 'silent !touch' g:solarized_palette
      \| let g:solarized_termcolors=16
      \| execute 'source' g:current_colour

command! SolarizedColourDegraded execute 'silent !rm' g:solarized_palette
      \| let g:solarized_termcolors=256
      \| execute 'source' g:current_colour

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

" Default to degraded solarized to avoid bad colours on new machines.
if !filereadable(g:solarized_palette)
  let g:solarized_termcolors=256
endif

" Use the last chosen colour scheme or default to a dark colorscheme.
if filereadable(expand(g:current_colour))
  execute 'source' g:current_colour
else
  Alduin
endif
