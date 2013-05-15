#!/bin/sh

# This script pulls extra software and creates appropriate symlinks in the home
# directory
# Run from where it's located (within dotfiles directory)

# Make a known_hosts file if none, otherwise zsh throws an error for our .zshrc
if test -f ~/.ssh/known_hosts; then
  echo "known_hosts found..."
else
  mkdir -p ~/.ssh
  touch ~/.ssh/known_hosts
  echo "known_hosts created (blank)..."
fi

# Ack for this user (perl 5.8.8 or higher on system)
# Curl may need to have proxy settings
if test -f ~/bin/ack; then
  echo "ack found..."
else
  mkdir -p ~/bin
  curl http://betterthangrep.com/ack-standalone > ~/bin/ack
  chmod 0755 ~/bin/ack
  echo "ack installed from betterthangrep.com..."
fi

# color for git! Some machines don't have it.
git config --global color.ui true
git config --global core.editor "vim"
echo "git colour and editor setup..."

# This repository has vim plugins as submodules, so initialise and clone them
git submodule init
git submodule update
echo "dotfiles submodules done..."

#
# Thanks to: https://github.com/dangerous/dotfiles
# for cleaner way of handling symlinking
#
BACKUP_DIR="/tmp/$(date)"
mkdir "$BACKUP_DIR"

# Zsh
[ -f ~/.zshrc ] && mv ~/.zshrc "$BACKUP_DIR"
[ -f ~/.zshenv ] && mv ~/.zshenv "$BACKUP_DIR"
ln -s dotfiles/zsh/zshrc ~/.zshrc
ln -s dotfiles/zsh/zshenv ~/.zshenv

# Vim
[ -d ~/.vim ] && mv ~/.vim "$BACKUP_DIR"
[ -f ~/.vimrc ] && mv ~/.vimrc "$BACKUP_DIR"
ln -s dotfiles/vim ~/.vim
ln -s dotfiles/vim/vimrc ~/.vimrc
mkdir -p ~/.vim/undo # persistent undo folder

# Vimperator
[ -d ~/.vimperator ] && mv ~/.vimperator "$BACKUP_DIR"
[ -f ~/.vimperatorrc ] && mv ~/.vimperatorrc "$BACKUP_DIR"
ln -s dotfiles/vimperator ~/.vimperator
ln -s dotfiles/vimperator/vimperatorrc ~/.vimperatorrc

# Screen
[ -f ~/.screenrc ] && mv ~/.screenrc "$BACKUP_DIR"
ln -s dotfiles/screen/screenrc ~/.screenrc

# Tmux
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf "$BACKUP_DIR"
ln -s dotfiles/tmux/tmux.conf ~/.tmux.conf

# Powerline
# `.config` is a shared config location, so take more care
[ -d ~/.config/powerline ] && mv ~/.config/powerline "$BACKUP_DIR"
[ ! -d ~/.config ] && mkdir ~/.config
ln -s ../dotfiles/powerline/config ~/.config/powerline

# Nethack
[ -f ~/.nethackrc ] && mv ~/.nethackrc "$BACKUP_DIR"
ln -s dotfiles/nethack/nethackrc ~/.nethackrc

# Irssi
[ -d ~/.irssi ] && mv ~/.irssi "$BACKUP_DIR"
ln -s dotfiles/irssi ~/.irssi

# Mongo
[ -f ~/.mongorc.js ] && mv ~/.mongorc.js "$BACKUP_DIR"
ln -s dotfiles/mongo/mongorc.js ~/.mongorc.js

echo "Setup complete!"
