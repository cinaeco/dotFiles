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

Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'joonty/vdebug'
Plug 'tpope/vim-repeat'
Plug 'kshenoy/vim-signature'
Plug 'itchyny/lightline.vim'
Plug 'haya14busa/vim-asterisk'

Plug 'nathanaelkane/vim-indent-guides'
Plug 'altercation/vim-colors-solarized'
Plug 'cinaeco/EasyGrep'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-multiple-cursors'
Plug 'matchit.zip'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'tristen/vim-sparkup'
"Plug 'sjl/gundo.vim'
"Plug 'katono/rogue.vim'
"Plug 'haya14busa/incsearch.vim' - interferes with macros
"Plug 'deris/vim-shot-f' - interferes with macro

" Text Objects {{{
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'bkad/CamelCaseMotion'
Plug 'vim-scripts/argtextobj.vim'
" }}}

" File Browser {{{
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
" }}}

" Code Browser {{{
if executable('ctags')
  Plug 'majutsushi/tagbar'
  if executable('phpctags')
    Plug 'vim-php/tagbar-phpctags.vim'
  endif
endif
" }}}

" Completion and Snippets {{{
"Plug 'ervandew/supertab'
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'garbas/vim-snipmate'
"Plug 'honza/vim-snippets'
"" Source support_function.vim to support vim-snippets.
"if filereadable(expand("~/.vim/bundle/vim-snippets/snippets/support_functions.vim"))
  "source ~/.vim/bundle/vim-snippets/snippets/support_functions.vim
"endif
Plug 'ajh17/VimCompletesMe'
" }}}

" Coding Language Support {{{
Plug 'shawncplus/phpcomplete.vim'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-cucumber'
Plug 'quentindecock/vim-cucumber-align-pipes'
Plug 'kchmck/vim-coffee-script'
Plug 'mintplant/vim-literate-coffeescript'
Plug 'groenewege/vim-less'
Plug 'elzr/vim-json'
Plug 'vim-scripts/yaml.vim'
Plug 'LnL7/vim-nix'
" }}}

call plug#end()
