let g:ctrlp_map = '<Leader>p'

" Use `ag` as fallback if available.
if executable('ag')
  let s:fallback = 'ag %s -l --nocolor -g ""'
else
  let s:fallback = 'find %s -type f'
endif

let g:ctrlp_user_command = [
  \ '.git',
  \ 'cd %s && git ls-files . -co --exclude-standard',
  \ s:fallback
\]

let g:ctrlp_extensions = ['funky']

" Function definition jumping with CtrlP's Funky plugin.
nnoremap <silent> <Leader>f :CtrlPFunky<CR>
