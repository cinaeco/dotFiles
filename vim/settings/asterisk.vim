" vim-asterisk
" Improved * and # behaviour
"  - cursor does not immediately jump
"  - relative cursor position across */# searches remain
"  - works with visual selection
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1
