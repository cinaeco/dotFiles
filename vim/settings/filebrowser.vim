" Netrw - Vim's built-in file browser.

" Open and close file browser with `<Leader>d`
nmap <silent> <Leader>d :Explore<CR>
autocmd FileType netrw map <silent> <buffer> <Leader>d :Rexplore<CR>

" Open files and toggle folders with 'o' like in QuickFix.
autocmd FileType netrw map <silent> <buffer> o <CR>

" Errors should not open new splits. Use normal error handling, `:messages`.
let g:netrw_use_errorwindow = 0

" Use tree-style browsing by default
" 0 = normal, 1 = details, 2 = ls, 3 = tree
let g:netrw_liststyle = 3
