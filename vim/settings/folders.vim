" Set up folders to be used for various temporary files, based on vim settings.
" Features should be toggled in `vimrc`, or any other file before this is run.
function! InitVimFolders()

  " Vim folders will look like `~/.vimsomething`.
  let prefix = $HOME . '/.vim'

  " List the folders to be made.
  let folders = {}
  if &swapfile
    let folders['swap'] = 'directory'
  endif
  if &backup
    let folders['backup'] = 'backupdir'
  endif
  if has('persistent_undo') && &undofile
    let folders['undo'] = 'undodir'
  endif

  " Create the folders.
  for [folder, setting] in items(folders)
    let path = prefix . folder . '/'

    if !isdirectory(path)
      if exists("*mkdir")
        call mkdir(path, "p")
      endif
    endif

    " Use the folders.
    if isdirectory(path)
      let path = substitute(path, " ", "\\\\ ", "g")
      exec "set " . setting . "=" . path
    else
      echo "Warning! Could not create folder: " . path
      echo "Try `mkdir -p " . path . "`"
    endif
  endfor
endfunction

call InitVimFolders()
