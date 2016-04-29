" Formatting for json files
"au FileType json setlocal equalprg=python\ -m\ json.tool

" yaml highlighting
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/plugged/yaml.vim/colors/yaml.vim

" `.conf` and `.ini` files should not force text to the next line.
au BufEnter *.conf,*.ini setlocal textwidth=0

" RiotJS Tag support
au BufNewFile,BufRead *.tag setlocal ft=javascript

" Add spelling to markdown files
autocmd BufRead,BufNewFile *.md setlocal spell
