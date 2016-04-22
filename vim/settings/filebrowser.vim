" Dirvish file browser.

" Use relative paths if there is no `conceal` ability.
let g:dirvish_relative_paths = (v:version <= 703 ? 1 : 0)

augroup dirvishCustomisation
  autocmd!

  " Allow fugitive.vim commands in dirvish buffers.
  autocmd FileType dirvish call fugitive#detect(@%)

  " Use 'o' to (o)pen and 'i' to spl(i)t.
  autocmd FileType dirvish let s:nowait = (v:version > 703 ? '<nowait>' : '')
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> o :<C-U>.call dirvish#open("edit", 0)<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> i :<C-U>.call dirvish#open("split", 1)<CR>'
        \| execute 'xnoremap '.s:nowait.'<buffer><silent> O :call dirvish#open("edit", 0)<CR>'
        \| execute 'xnoremap '.s:nowait.'<buffer><silent> I :call dirvish#open("split", 1)<CR>'
augroup END

" CtrlP - Fuzzy Finder in Vimscript

"let g:ctrlp_map = '<Leader>p'

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
map <silent> <Leader>f :CtrlPFunky<CR>


" FZF - Fuzzy Finder in Go/Ruby

map <silent> <Leader>p :FZF<CR>
