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
  " - Add, Copy, Delete, Rename with 'ma', 'mc', 'md', 'mr'.
  autocmd FileType dirvish let s:nowait = (v:version > 703 ? '<nowait>' : '')
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> o :<C-U>.call dirvish#open("edit", 0)<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> i :<C-U>.call dirvish#open("split", 1)<CR>'
        \| execute 'xnoremap '.s:nowait.'<buffer><silent> O :call dirvish#open("edit", 0)<CR>'
        \| execute 'xnoremap '.s:nowait.'<buffer><silent> I :call dirvish#open("split", 1)<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> ma :<C-U>.call FileAdd()<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> mc :<C-U>.call FileCopy()<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> md :<C-U>.call FileDelete()<CR>'
        \| execute 'nnoremap '.s:nowait.'<buffer><silent> mr :<C-U>.call FileRename()<CR>'
augroup END

" Create any directories required.
function! CreateDirs(filename)
  if &ft != "dirvish" | return | endif
  let dirname = fnamemodify(a:filename, ':p:h')
  if dirname != expand('%:h') | call system('mkdir -p '.dirname) | endif
endfunction

" Create files/directories in dirvish buffers.
function! FileAdd()
  if &ft != "dirvish" | return | endif
  let newfile = inputdialog('New File: ', expand('%'), 0)
  if newfile == "0" | return | endif
  call CreateDirs(newfile)
  if !isdirectory(newfile)
    execute 'edit' newfile
  else
    normal R
  endif
endfunction

" Rename files/directories in dirvish buffers.
function! FileCopy()
  if &ft != "dirvish" | return | endif
  let current = getline('.')
  let newname = inputdialog('Copy: ', current, 0)
  if newname == "0" | return | endif
  call CreateDirs(newname)
  call system('cp '.current.' '.newname) | normal R
endfunction

" Delete files/directories in dirvish buffers.
function! FileDelete()
  if &ft != "dirvish" | return | endif
  let current = getline('.')
  if current == '/' | return | endif " Do not do the silly thing.
  let delcheck = confirm('Delete `'.current.'`?', "&Yes\n&No", 2)
  if delcheck != 1 | return | endif
  let delcheck = confirm('Are you SURE?', "&Yes\n&No", 2)
  if delcheck != 1 | return | endif
  call system('rm -rf '.current) | normal R
endfunction

" Rename files/directories in dirvish buffers.
function! FileRename()
  if &ft != "dirvish" | return | endif
  let current = getline('.')
  let newname = inputdialog('Rename: ', current, 0)
  if newname == "0" | return | endif
  call CreateDirs(newname)
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
