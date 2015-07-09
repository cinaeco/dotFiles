" Pandoc files are to explicitly use `.pandoc`.
" Normal markdown files should not use Pandoc Markdown behaviours.
let g:pandoc#filetypes#pandoc_markdown = 0

" Pandoc's syntax concealing does fancy character conversions e.g. '...' to
" proper ellipsis. However, the conceal highlighting often does not work well
" with the Goyo/Limelight (distraction-free writing) plugins, which otherwise
" complement Pandoc.
let g:pandoc#syntax#conceal#use = 0

" Write `docx` versions of `pandoc` files on save.
let g:pandoc#command#autoexec_on_writes = 1
let g:pandoc#command#autoexec_command = 'Pandoc docx'
