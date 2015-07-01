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

" General {{{
Plug 'Raimondi/delimitMate'
Plug 'dkprice/vim-easygrep'
Plug 'godlygeek/tabular'
Plug 'haya14busa/vim-asterisk'
Plug 'joonty/vdebug'
Plug 'matchit.zip'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
" }}}

" Visual {{{
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'kshenoy/vim-signature'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'romainl/flattened'
Plug 'Sclarki/neonwave.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" }}}

" Text Objects {{{
Plug 'bkad/CamelCaseMotion'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-surround'
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
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/yaml.vim'
" }}}

" Games. Why not {{{
Plug 'katono/rogue.vim'
Plug 'jmanoel7/vim-games'
" }}}

" Discarded {{{
"Plug 'deris/vim-shot-f' - interferes with macro
"Plug 'haya14busa/incsearch.vim' - interferes with macros
"Plug 'scrooloose/nerdtree' - moved away from drawer-style browser to netrw.
"Plug 'terryma/vim-expand-region' - cool, but often slower than text objects.
"
"Plug 'MarcWeber/vim-addon-mw-utils' -\
"Plug 'ervandew/supertab' ------------|
"Plug 'garbas/vim-snipmate' ----------+ ancient and messy completion system.
"Plug 'honza/vim-snippets' -----------|
"Plug 'tomtom/tlib_vim' --------------/
" }}}

call plug#end()
