" Formatting for json files
au FileType json setlocal equalprg=python\ -m\ json.tool

" yaml highlighting
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/plugged/yaml.vim/colors/yaml.vim

" `.conf` and `.ini` files should not force text to the next line.
au BufEnter *.conf,*.ini setlocal textwidth=0

" Load coffee script plugin for literate coffeescript files as well
autocmd FileType litcoffee runtime ftplugin/coffee.vim
" Compile and Watch should open vertical splits by default
let coffee_compile_vert = 1
let coffee_watch_vert = 1
