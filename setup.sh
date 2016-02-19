#!/bin/bash
# vim: set sw=2 ts=2 sts=2 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:
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
backup_dir=~/.backup/dotfiles/$(date "+%Y-%m-%d-%H%M%S")
mkdir -p "$backup_dir" ~/.ssh ${XDG_CONFIG_HOME:=$HOME/.config}
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

# Tmux
linkup ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
echo "Tmux linked."

# Ack
linkup ~/dotfiles/ack/ackrc ~/.ackrc
echo "Ack linked."

# Vim
linkup ~/dotfiles/vim ~/.vim
linkup ~/dotfiles/vim/vimrc ~/.vimrc
echo "Vim linked."

# NeoVim XDG Config
linkup ~/dotfiles/vim $XDG_CONFIG_HOME/nvim
linkup ~/dotfiles/vim/vimrc $XDG_CONFIG_HOME/nvim/init.vim
echo "NeoVim linked."

# vim-plug install process. Starts with plugin list and `nocompatible` flag.
vim -u ~/dotfiles/vim/plugins.vim -N +PlugClean! +PlugUpdate! +quitall!
echo "Vim plugins done."

echo "Setup complete!"
