" Function definition jumping with CtrlP's Funky plugin
nnoremap <silent> <C-F> :CtrlPFunky<CR>

"let g:ctrlp_working_path_mode = 'rw' let's try out ra
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': 'find %s -type f'
\ }
let g:ctrlp_extensions = ['funky']
