set laststatus=2
set noshowmode " don't show e.g. --INSERT-- with fancy status lines.

" Powerline
"set rtp+=~/dotfiles/powerline/powerline/powerline/bindings/vim

let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline_theme = 'powerlineish'
if g:colors_name == 'neonwave'
  let g:airline_theme = 'surarken'
endif
