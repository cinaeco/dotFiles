" Netrw - Vim's built-in file browser.

" Put errors in `:messages`
let g:netrw_use_errorwindow = 0

" 'o' to (o)pen
autocmd FileType netrw map <silent> <buffer> o <CR>


" Dirvish file browser.

" Use relative paths if there is no `conceal` ability.
let g:dirvish_relative_paths = (v:version <= 703 ? 1 : 0)

augroup dirvishCustomisation
  autocmd!

  " Allow fugitive.vim commands in dirvish buffers.
  autocmd FileType dirvish call fugitive#detect(@%)

  " Add/Adjust mappings.
  " - 'o' to (o)pen and 'i' to spl(i)t.
  " - Create, Delete, Rename with 'mc', 'md', 'mr'.
  autocmd FileType dirvish let s:nowait = (v:version > 703 ? '<nowait>' : '')
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> o :<C-U>.call dirvish#open("edit", 0)<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> i :<C-U>.call dirvish#open("split", 1)<CR>'
        \| execute 'xnoremap '.s:nowait.'<buffer><silent> O :call dirvish#open("edit", 0)<CR>'
        \| execute 'xnoremap '.s:nowait.'<buffer><silent> I :call dirvish#open("split", 1)<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> mc :<C-U>.call FileCreate()<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> md :<C-U>.call FileDelete()<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> mr :<C-U>.call FileRename()<CR>'
augroup END

" Create files/directories in dirvish buffers.
function! FileCreate()
  if &ft != "dirvish" | return | endif
  let filename = inputdialog('New File: ', expand('%'), 0)
  if filename == "0" | return | endif
  " Create any directories required.
  let dirname = fnamemodify(filename, ':p:h')
  if dirname != expand('%:h') | call system('mkdir -p '.dirname) | endif
  " Edit the file if it is a file.
  if !isdirectory(filename)
    execute 'edit' filename
  else
    normal R
  endif
endfunction

" Delete files/directories in dirvish buffers.
function! FileDelete()
  if &ft != "dirvish" | return | endif
  let current = getline('.')
  let delcheck = confirm('Delete `'.current.'`?', "&Yes\n&No", 2)
  if delcheck != 1 | return | endif
  let delcheck = confirm('Are you SURE?', "&Yes\n&No", 2)
  if delcheck != 1 | return | endif
  call delete(current, 'rf') | normal R
endfunction

" Rename files/directories in dirvish buffers.
function! FileRename()
  if &ft != "dirvish" | return | endif
  let current = getline('.')
  let newname = inputdialog('Rename: ', current, 0)
  if newname == "0" | return | endif
  call rename(current, newname) | normal R
endfunction


" Fuzzy Finder

" Set `<Leader>p` to FZF if possible. CtrlP is always available at `<C-p>`
if executable('fzf')
  map <silent> <Leader>p :FZF<CR>
else
  let g:ctrlp_map = '<Leader>p'
endif

" CtrlP uses `git ls-files` in git repos, otherwise `ag` then `find`.
let g:ctrlp_user_command = [
  \ '.git',
  \ 'cd %s && git ls-files . -co --exclude-standard',
  \ executable('ag') ? 'ag %s -l --nocolor -g ""' : 'find %s -type f'
\]

" CtrlP Funky plugin - jump to function definitions in the current file.
let g:ctrlp_extensions = ['funky']
map <silent> <Leader>f :CtrlPFunky<CR>
