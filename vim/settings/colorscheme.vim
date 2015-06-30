set background=dark
"let g:solarized_termcolors=256
"colorscheme solarized
"colorscheme neonwave
colorscheme flattened_dark

" Fix wrong background colour in tmux.
" http://sunaku.github.io/vim-256color-bce.html
set t_ut=

" Fix sign column colour (e.g. for vim-signature, syntastic).
highlight SignColumn ctermbg=235

" Mute coloured spell check errors.
" Note: Highlights must be cleared first, or linking will fail.
function! MuteSpellCheckHighlights()
  hi clear SpellBad
  hi SpellBad cterm=underline
  hi clear SpellCap
  hi link SpellCap SpellBad
  hi clear SpellLocal
  hi link SpellLocal SpellBad
  hi clear SpellRare
  hi link SpellRare SpellBad
endfunction

"nmap <silent> <F5> :call MuteSpellCheckHighlights()<CR>
