#!/bin/bash
# vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker spell:
set -euo pipefail
IFS=$'\n\t'

# Support Functions {{{

# Backup a given file.
backup() {
  [[ -e "$1" ]] && mv "$1" "$backup_dir" || true
}

# Create links after backing up.
linkup() {
  backup "$2"; ln -sf "$1" "$2"
}

# }}}

# Prepare folders
backup_dir=~/.dotfilesbackup/$(date)
mkdir -p "$backup_dir" ~/.ssh
echo "Prepared folders."

# Make known_hosts file if none
touch ~/.ssh/known_hosts
echo "Touched known hosts."

# Git config
git config --global color.ui true
git config --global core.editor vim
git config --global core.excludesfile ~/dotfiles/git/globalignore
git config --global diff.mnemonicPrefix true
echo "Git config done."

# Initialise and clone any submodules
(cd ~/dotfiles && git submodule sync && git submodule update --init)
echo "Submodules done."

# Zsh
linkup ~/dotfiles/zsh/zshenv ~/.zshenv
linkup ~/dotfiles/zsh/zshrc ~/.zshrc
echo "Zsh linked."

# Vimperator
linkup ~/dotfiles/vimperator ~/.vimperator
linkup ~/dotfiles/vimperator/vimperatorrc ~/.vimperatorrc
echo "Vimperator linked."

# Screen
linkup ~/dotfiles/screen/screenrc ~/.screenrc
echo "Screen linked."

# Tmux
linkup ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
echo "Tmux linked."

# Irssi
linkup ~/dotfiles/irssi ~/.irssi
echo "Irssi linked."

# Ack
linkup ~/dotfiles/ack/ackrc ~/.ackrc
echo "Ack linked."

# Vim (and NeoVim)
linkup ~/dotfiles/vim/vimrc ~/.vimrc
linkup ~/dotfiles/vim/vimrc ~/.nvimrc
linkup ~/dotfiles/vim ~/.vim
linkup ~/dotfiles/vim ~/.nvim
echo "Vim linked."

# vim-plug install process. Starts with plugin list and `nocompatible` flag.
vim -u ~/dotfiles/vim/plugins.vim -N +PlugClean! +PlugUpdate! +quitall!
echo "Vim plugins done."

echo "Setup complete!"
