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

# Download vim-plug, a vim plugin manager.
#
# Also place vim-plug where it can be auto-loaded.
download_vim_plug() {
  folder=~/.vim/plugged/vim-plug
  if [ ! -e $folder ]; then
    echo "Vim Plugin Manager cloning"
    git clone https://github.com/junegunn/vim-plug.git $folder --depth 1
  else
    echo "Vim Plugin Manager updating"
    cd $folder && git pull
  fi
  mkdir -p ~/.vim/autoload
  linkup "$folder/plug.vim" ~/.vim/autoload/plug.vim
}

# Run vim-plug's install process.
#
# Vim is loaded with only the registry of plugins and the `nocompatible` flag.
install_vim_plugins() {
  vim -u ~/dotfiles/vim/plugins.vim -N +PlugInstall +PlugClean +qall
}

# }}}

# Make known_hosts file if none
mkdir -p ~/.ssh
touch ~/.ssh/known_hosts
echo "We touched all the known hosts."

# Git config
git config --global color.ui true
git config --global core.editor "vim"
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
mkdir -p ~/.vim-tmp
linkup ~/.vim-tmp ~/.vim
linkup ~/.vim-tmp ~/.nvim
download_vim_plug
install_vim_plugins
echo "Vim linked."

echo "Setup complete!"
