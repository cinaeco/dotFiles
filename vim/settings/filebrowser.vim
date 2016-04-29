" Dirvish file browser.

" Use relative paths if there is no `conceal` ability.
let g:dirvish_relative_paths = (v:version <= 703 ? 1 : 0)

augroup dirvishCustomisation
  autocmd!

  " Allow fugitive.vim commands in dirvish buffers.
  autocmd FileType dirvish call fugitive#detect(@%)

  " Add/Adjust mappings.
  " - Reverse 'o' to (o)pen and 'i' to spl(i)t.
  " - `mc` to create a file.
  autocmd FileType dirvish let s:nowait = (v:version > 703 ? '<nowait>' : '')
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> o :<C-U>.call dirvish#open("edit", 0)<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> i :<C-U>.call dirvish#open("split", 1)<CR>'
        \| execute 'xnoremap '.s:nowait.'<buffer><silent> O :call dirvish#open("edit", 0)<CR>'
        \| execute 'xnoremap '.s:nowait.'<buffer><silent> I :call dirvish#open("split", 1)<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer> mc :e %'
augroup END

" CtrlP - Fuzzy Finder in Vimscript

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

" Function definition jumping with CtrlP's Funky plugin.
let g:ctrlp_extensions = ['funky']
map <silent> <Leader>f :CtrlPFunky<CR>


" FZF - Fuzzy Finder in Go/Ruby

map <silent> <Leader>p :FZF<CR>
