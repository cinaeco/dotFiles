" Pandoc files are to explicitly use `.pandoc`.
" Normal markdown files should not use Pandoc Markdown behaviours.
let g:pandoc#filetypes#pandoc_markdown = 0

" Pandoc's syntax concealing does fancy character conversions e.g. '...' to
" proper ellipsis. However, the conceal highlighting often does not work well
" with the Goyo/Limelight (distraction-free writing) plugins, which otherwise
" complement Pandoc.
let g:pandoc#syntax#conceal#use = 0

" Hard-wrap lines to 80 characters, except for headers and code blocks.
let g:pandoc#formatting#mode = 'h'
let g:pandoc#formatting#textwidth = 80

" Write `docx` versions of `pandoc` files on save.
let g:pandoc#command#autoexec_on_writes = 1
let g:pandoc#command#autoexec_command = 'Pandoc docx'

" Correct spelling using first suggestion from spell check.
map <leader>z 1z=

" Omni-complete from bibliographic sources e.g. bibtex. Citekeys start with '@'.
autocmd FileType pandoc let b:vcm_omni_pattern = '@'

" Create revealjs slides from pandoc_slides files.
autocmd BufRead,BufNewFile *.pandoc_slides set filetype=pandoc
     \| let b:pandoc_command_autoexec_command = "Pandoc revealjs"
