#!/bin/sh
# Setup Script {{{
# vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker spell:
#
#   Creates links to configuration files in a user's home folder and downloads
#   extra software and plugins.
#
#   Run from where it's located within dotfiles directory
#
#       ./setup.sh
#
# }}}

# Support Functions {{{

# Folder for backing up present configuration files.
backup_dir="/tmp/$(date)"
mkdir "$backup_dir"

# Backup a given file.
backup() {
  [ -e "$1" ] && mv "$1" "$backup_dir"
}

# Create links after backing up.
linkup() {
  backup "$2"
  ln -s "$1" "$2"
}

# Run vim-plug's install process.
# Vim starts with just a registry of plugins and the `nocompatible` flag.
install_vim_plugins() {
  vim -u ~/dotfiles/vim/plugins.vim -N +PlugUpgrade +PlugUpdate! +PlugClean! +qall!
}

# }}}

# Make known_hosts file if none
mkdir -p ~/.ssh
touch ~/.ssh/known_hosts
echo "We touched all the known hosts."

# Git config
git config --global color.ui true
git config --global core.editor "vim"
git config --global core.excludesfiles ~/dotfiles/git/globalignore
echo "Git config done."

# Initialise and clone any submodules
git submodule sync
git submodule update --init
echo "Submodules done."

# Zsh
linkup ~/dotfiles/zsh/zshrc ~/.zshrc
linkup ~/dotfiles/zsh/zshenv ~/.zshenv
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

# Powerline
mkdir -p ~/.config
linkup ~/dotfiles/powerline/config ~/.config/powerline
echo "Powerline linked."

# Vim (and NeoVim)
linkup ~/dotfiles/vim/vimrc ~/.vimrc
linkup ~/dotfiles/vim/vimrc ~/.nvimrc
linkup ~/dotfiles/vim ~/.vim
linkup ~/dotfiles/vim ~/.nvim
install_vim_plugins
echo "Vim linked."

echo "Setup complete!"
