" Plugins {{{
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker spell:
"
"   Vim Plugin Setup Script
"
"   This file is used from 2 places:
"    - vimrc
"    - setup.sh
" }}}

call plug#begin('~/.vim/plugged')

"if executable('ack-grep')
  "let g:ackprg="ack-grep -H --nocolor --nogroup --column"
  "Plug 'mileszs/ack.vim'
"elseif executable('ack')
  "Plug 'mileszs/ack.vim'
"elseif executable('ag')
  "Plug 'mileszs/ack.vim'
  "let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
"endif

Plug 'Raimondi/delimitMate'
Plug 'altercation/vim-colors-solarized'
Plug 'godlygeek/tabular'
Plug 'haya14busa/vim-asterisk'
Plug 'itchyny/lightline.vim'
Plug 'joonty/vdebug'
Plug 'kshenoy/vim-signature'
Plug 'matchit.zip'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdcommenter'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Text Objects {{{
Plug 'bkad/CamelCaseMotion'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'vim-scripts/argtextobj.vim'
" }}}

" File Browser {{{
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-vinegar'
" }}}

" Code Browser {{{
Plug 'tacahiroy/ctrlp-funky'
if executable('ctags')
  Plug 'majutsushi/tagbar'
  if executable('phpctags')
    Plug 'vim-php/tagbar-phpctags.vim'
  endif
endif
" }}}

" Completion and Snippets {{{
Plug 'ajh17/VimCompletesMe'
" }}}

" Coding Language Support {{{
Plug 'LnL7/vim-nix'
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'
Plug 'kchmck/vim-coffee-script'
Plug 'mintplant/vim-literate-coffeescript'
Plug 'quentindecock/vim-cucumber-align-pipes'
Plug 'scrooloose/syntastic'
Plug 'shawncplus/phpcomplete.vim'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/yaml.vim'
" }}}

" Games. Why not {{{
Plug 'katono/rogue.vim'
" }}}

" Discarded {{{
"Plug 'deris/vim-shot-f' - interferes with macro
"Plug 'haya14busa/incsearch.vim' - interferes with macros
"Plug 'scrooloose/nerdtree' - moved away from drawer-style browser to netrw.
"
"Plug 'MarcWeber/vim-addon-mw-utils' -\
"Plug 'ervandew/supertab' ------------|
"Plug 'garbas/vim-snipmate' ----------+ ancient and messy completion system.
"Plug 'honza/vim-snippets' -----------|
"Plug 'tomtom/tlib_vim' --------------/
" }}}

call plug#end()
