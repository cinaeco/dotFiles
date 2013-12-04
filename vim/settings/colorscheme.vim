""""""""
"" UI - Solarized Fix
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Fix solarized scheme in spf13-vim. The config sets up to use the degraded
" 256-color mode for sake of some terminal emulators? (see
" https://github.com/spf13/spf13-vim/issues/113).
"
" These two lines Must come in this order or they won't work: number and fold
" columns and cursor line come out brownish (dark scheme) or black (light
" scheme).
"let g:solarized_termcolors=16
"set t_Co=16
set background=dark         " Assume a dark background
colorscheme solarized
