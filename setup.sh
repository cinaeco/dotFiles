#!/bin/sh
# Setup Script - Modeline and Notes {{{
# vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker spell:
#
#   Automated Setup Script - cinaeco/dotfiles
#
#   This script creates appropriate symlinks in the home folder and pulls
#   extra software and plugins where available.
#
#   Run from where it's located within dotfiles directory i.e. `./setup.sh`
#
# }}}

# Script Helper Functions {{{
#
#   These are mostly taken from spf13-vim. They are primarily here to setup
#   vundle beforehand, to avoid the chicken-and-egg issue.
#
debug_mode='0'

lnif() {
  if [ -e "$1" ]; then
    ln -sf "$1" "$2"
  fi
  ret="$?"
  debug
}

msg() {
  printf '%b\n' "$1" >&2
}

success() {
  if [ "$ret" -eq '0' ]; then
    msg "\e[32m[✔]\e[0m ${1}${2}"
  fi
}

debug() {
  if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
    msg "An error occured in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
  fi
}

upgrade_repo() {
  msg "trying to update $1"

  if [ "$1" = "$app_name" ]; then
    cd "$HOME/.$app_name-3" &&
      git pull origin "$git_branch"
  fi

  if [ "$1" = "vundle" ]; then
    cd "$HOME/.vim/bundle/vundle" &&
      git pull origin master
  fi

  ret="$?"
  success "$2"
  debug
}

create_vimlinks() {
  dotfilesvim="$HOME/dotfiles/vim"

  if [ ! -d "$HOME/.cinaeco-vim" ]; then
    mkdir -p "$HOME/.cinaeco-vim"
  fi
  endpath="$HOME/.cinaeco-vim"

  if [ ! -d "$endpath/.vim/bundle" ]; then
    mkdir -p "$endpath/.vim/bundle"
  fi

  lnif "$dotfilesvim/vimrc"              "$HOME/.vimrc"
  lnif "$dotfilesvim/vimrc.bundles"      "$HOME/.vimrc.bundles"
  lnif "$endpath/.vim"                    "$HOME/.vim"

  ret="$?"
  success "$1"
  debug
}

clone_vundle() {
  if [ ! -e "$HOME/.vim/bundle/vundle" ]; then
    git clone https://github.com/gmarik/vundle.git "$HOME/.vim/bundle/vundle"
  else
    upgrade_repo "vundle"   "Successfully updated vundle"
  fi
  ret="$?"
  success "$1"
  debug
}

setup_vundle() {
  system_shell="$SHELL"
  export SHELL='/bin/sh'
  vim -u "$HOME/.vimrc.bundles" +BundleInstall! +BundleClean +qall
  export SHELL="$system_shell"

  success "$1"
  debug
}
# }}}

# Make known_hosts file if none {{{
#
#   Otherwise, zsh throws an error for our .zshrc
#
if test -f ~/.ssh/known_hosts; then
  ret="$?"
  success "File 'known_hosts' found"
else
  mkdir -p ~/.ssh
  touch ~/.ssh/known_hosts
  ret="$?"
  success "File 'known_hosts' created (blank)"
fi
# }}}

# Get the ack search tool {{{
#
#   Requires perl 5.8.8 or higher. Curl may need to have proxy settings.
#
if test -f ~/bin/ack; then
  ret="$?"
  success "Ack found"
else
  mkdir -p ~/bin
  curl http://beyondgrep.com/ack-2.04-single-file > ~/bin/ack && chmod 0755 ~/bin/ack
  ret="$?"
  success "Ack installed from beyondgrep.com"
fi
# }}}

# Git: colorise output, edit with vim {{{
#
#   Makes status', diffs and logs much nicer to use.
#
git config --global color.ui true
git config --global core.editor "vim"
success "Git colour and editor setup"
# }}}

# Initialise and clone any submodules {{{
git submodule init
git submodule update
success "Submodules done"
# }}}

# Setup Backup Folder for old configuration files {{{
#
#   This way the setup script is pretty non-destructive, and can be run
#   repeatedly without bad side effects.
#
BACKUP_DIR="/tmp/$(date)"
mkdir "$BACKUP_DIR"
# }}}

# Zsh {{{
[ -f ~/.zshrc ] && mv ~/.zshrc "$BACKUP_DIR"
[ -f ~/.zshenv ] && mv ~/.zshenv "$BACKUP_DIR"
ln -s dotfiles/zsh/zshrc ~/.zshrc
ln -s dotfiles/zsh/zshenv ~/.zshenv
success "Zsh config linked"
# }}}

# Vimperator {{{
[ -d ~/.vimperator ] && mv ~/.vimperator "$BACKUP_DIR"
[ -f ~/.vimperatorrc ] && mv ~/.vimperatorrc "$BACKUP_DIR"
ln -s dotfiles/vimperator ~/.vimperator
ln -s dotfiles/vimperator/vimperatorrc ~/.vimperatorrc
success "Vimperator config linked"
# }}}

# Screen {{{
[ -f ~/.screenrc ] && mv ~/.screenrc "$BACKUP_DIR"
ln -s dotfiles/screen/screenrc ~/.screenrc
success "Screen config linked"
# }}}

# Tmux {{{
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf "$BACKUP_DIR"
ln -s dotfiles/tmux/tmux.conf ~/.tmux.conf
success "Tmux config linked"
# }}}

# Powerline {{{
# `.config` is a shared config location, so take more care
[ -d ~/.config/powerline ] && mv ~/.config/powerline "$BACKUP_DIR"
[ ! -d ~/.config ] && mkdir ~/.config
ln -s ../dotfiles/powerline/config ~/.config/powerline
success "Powerline config linked"
# }}}

# Nethack {{{
[ -f ~/.nethackrc ] && mv ~/.nethackrc "$BACKUP_DIR"
ln -s dotfiles/nethack/nethackrc ~/.nethackrc
success "Nethack config linked"
# }}}

# Irssi {{{
[ -d ~/.irssi ] && mv ~/.irssi "$BACKUP_DIR"
ln -s dotfiles/irssi ~/.irssi
success "Irssi config linked"
# }}}

# Mongo {{{
[ -f ~/.mongorc.js ] && mv ~/.mongorc.js "$BACKUP_DIR"
ln -s dotfiles/mongo/mongorc.js ~/.mongorc.js
success "Mongo config linked"
# }}}

# Sqlite {{{
[ -f ~/.sqliterc ] && mv ~/.sqliterc "$BACKUP_DIR"
ln -s dotfiles/sqlite/sqliterc ~/.sqliterc
success "Sqlite config linked"
# }}}

# Ack {{{
[ -f ~/.ackrc ] && mv ~/.ackrc "$BACKUP_DIR"
ln -s dotfiles/ack/ackrc ~/.ackrc
success "Ack config linked"
# }}}

# Emacs {{{
[ -f ~/.emacs ] && mv ~/.emacs "$BACKUP_DIR"
ln -s dotfiles/emacs/emacs ~/.emacs
success "Emacs config linked"
# }}}

# ZFS {{{
[ -f ~/bin/destroy-zfs-auto-snaps ] && mv ~/.vimrc "$BACKUP_DIR"
ln -s ../dotfiles/zfs/destroy-zfs-auto-snaps ~/bin
success "ZFS utilities installed"
# }}}

# Vim {{{
[ -d ~/.vim ] && mv ~/.vim "$BACKUP_DIR"
[ -f ~/.vimrc ] && mv ~/.vimrc "$BACKUP_DIR"
[ -f ~/.vimrc.bundles ] && mv ~/.vimrc.bundles "$BACKUP_DIR"
create_vimlinks "Setting up vim symlinks"
clone_vundle    "Successfully cloned vundle"
setup_vundle    "Now updating/installing plugins using Vundle"
# }}}

# Success {{{
ret="$?"
success "Setup complete!"
# }}}
