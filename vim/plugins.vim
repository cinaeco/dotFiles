" Plugins {{{
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=1 foldmethod=marker spell:
"
"   Vim Plugin Setup Script
"
"   This file is used from 2 places:
"    - vimrc
"    - setup.sh
" }}}

call plug#begin('~/.vim/plugged')

" General {{{
Plug 'Raimondi/delimitMate'
Plug 'dkprice/vim-easygrep'
Plug 'haya14busa/vim-asterisk'
Plug 'joonty/vdebug'
Plug 'junegunn/vim-easy-align'
Plug 'matchit.zip'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-scripts/visualrepeat'
" }}}

" Visual {{{
Plug 'Sclarki/airline-surarken'
Plug 'Sclarki/neonwave.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" }}}

" Text Objects {{{
" `,` to work with camel/snake case e.g. `ci,w`
" `e` to work with whole files e.g. `=ae`
" `s` to work with surrounds e.g. `cs{[`
" `a` to work with arguments e.g. `cia`
Plug 'bkad/CamelCaseMotion'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/argtextobj.vim'
" }}}

" File Browser {{{
Plug 'ctrlpvim/ctrlp.vim'
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
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'tobyS/pdv'
Plug 'tobyS/vmustache'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-scripts/yaml.vim'
Plug 'nicklasos/vim-jsx-riot'
" }}}

" Discarded {{{
"Plug 'deris/vim-shot-f' - interferes with macro
"Plug 'haya14busa/incsearch.vim' - interferes with macros
"Plug 'scrooloose/nerdtree' - moved away from drawer-style browser to netrw.
"Plug 'terryma/vim-expand-region' - cool, but often slower than text objects.
"Plug 'kshenoy/vim-signature' - nice, but mostly unused.
"Plug 'Yggdroot/indentLine' - performance issues in larger files.
"
"Plug 'MarcWeber/vim-addon-mw-utils' -\
"Plug 'ervandew/supertab' ------------|
"Plug 'garbas/vim-snipmate' ----------+ ancient and messy completion system.
"Plug 'honza/vim-snippets' -----------|
"Plug 'tomtom/tlib_vim' --------------/
"
" Games!
"Plug 'katono/rogue.vim' - Does not work with neovim.
"Plug 'jmanoel7/vim-games'
" }}}

call plug#end()
