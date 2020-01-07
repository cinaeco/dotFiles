" vim: set sw=2 ts=2 sts=2 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:
"
" The Plugin List
"

silent! call plug#begin('~/dotfiles/vim/plugged')

" General {{{
Plug 'Raimondi/delimitMate'
Plug 'adelarsq/vim-matchit'
Plug 'haya14busa/vim-asterisk'
Plug 'junegunn/vim-easy-align'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/visualrepeat'
if v:version >= 704
  Plug 'vim-pandoc/vim-pandoc'
endif
" }}}

" Visual {{{
Plug 'cinaeco/airline-surarken'
Plug 'cinaeco/neonwave.vim'
Plug 'briemens/vim-color-vanilla-cake'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-airline/vim-airline'
" }}}

" Text Objects {{{
" `s` to work with surrounds e.g. `cs{[`
" `a` to work with arguments e.g. `cia`
Plug 'tpope/vim-surround'
Plug 'vim-scripts/argtextobj.vim'
" }}}

" File Browser and Search {{{
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
if v:version >= 704 || (v:version == 703 && has('patch438'))
  Plug 'justinmk/vim-dirvish'
else
  Plug 'tpope/vim-vinegar'
endif
" }}}

" Completion and Snippets {{{
Plug 'ajh17/VimCompletesMe'
" }}}

" Coding Language Support {{{
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vimperator/vimperator.vim'
if v:version > 700 || (v:version == 700 && has('patch175'))
  Plug 'scrooloose/syntastic'
endif
" }}}

" Local Plugins {{{
if filereadable(expand("~/dotfiles/vim/plugins.vim.local"))
  source ~/dotfiles/vim/plugins.vim.local
endif
" }}}

call plug#end()
