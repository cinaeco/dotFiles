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

# Backup Folder for old configuration files {{{
#
#   The setup script is non-destructive, and can be run repeatedly - all old
#   config files or symlinks from previous runs can be recovered from
#   timestamped temp folders.
#
BACKUP_DIR="/tmp/$(date)"
mkdir "$BACKUP_DIR"
# }}}

# Symlink Attempt
lnif() {
  if [ -e "$1" ]; then
    ln -sf "$1" "$2"
  fi
  ret="$?"
  debug
}

# Backup files to backup folder
backup() {
  [ -f "$1" ] && mv "$1" "$BACKUP_DIR"
  ret="$?"
  debug
}

# Backup directories to backup folder
backup_dir() {
  [ -d "$1" ] && mv "$1" "$BACKUP_DIR"
  ret="$?"
  debug
}

msg() {
  printf '%b\n' "$1" >&2
}

success() {
  if [ "$ret" -eq '0' ]; then
    msg "\e[32m[+]\e[0m ${1}${2}"
  fi
}

debug() {
  if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
    msg "An error occured in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}"
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

  if [ ! -d "$HOME/.tmp-vim" ]; then
    mkdir -p "$HOME/.tmp-vim"
  fi
  vimfolder="$HOME/.tmp-vim"

  if [ ! -d "$vimfolder/.vim/bundle" ]; then
    mkdir -p "$vimfolder/.vim/bundle"
  fi

  lnif "$dotfilesvim/vimrc"              "$HOME/.vimrc"
  lnif "$dotfilesvim/vimrc.bundles"      "$HOME/.vimrc.bundles"
  lnif "$vimfolder/.vim"                    "$HOME/.vim"

  ret="$?"
  success "$1"
  debug
}

clone_vundle() {
  if [ ! -e "$HOME/.vim/bundle/vundle" ]; then
    git clone https://github.com/gmarik/vundle.git "$HOME/.vim/bundle/vundle"
  else
    upgrade_repo "vundle" "Successfully updated vundle"
  fi
  ret="$?"
  success "$1"
  debug
}

setup_vundle() {
  system_shell="$SHELL"
  export SHELL='/bin/sh'
  vim -u "$HOME/.vimrc.bundles" +PluginInstall! +PluginClean! +qall
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
git submodule sync
git submodule update --init
success "Submodules done"
# }}}

# Zsh {{{
backup ~/.zshrc
backup ~/.zshenv
lnif ~/dotfiles/zsh/zshrc ~/.zshrc
lnif ~/dotfiles/zsh/zshenv ~/.zshenv
success "Zsh config linked"
# }}}

# Vimperator {{{
backup_dir ~/.vimperator
backup ~/.vimperatorrc
lnif ~/dotfiles/vimperator ~/.vimperator
lnif ~/dotfiles/vimperator/vimperatorrc ~/.vimperatorrc
success "Vimperator config linked"
# }}}

# Screen {{{
backup ~/.screenrc
lnif ~/dotfiles/screen/screenrc ~/.screenrc
success "Screen config linked"
# }}}

# Tmux {{{
backup ~/.tmux.conf
lnif ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
success "Tmux config linked"
# }}}

# Powerline {{{
# `.config` is a shared config location, so take more care
backup_dir ~/.config/powerline
[ ! -d ~/.config ] && mkdir ~/.config
lnif ~/dotfiles/powerline/config ~/.config/powerline
success "Powerline config linked"
# }}}

# Irssi {{{
backup_dir ~/.irssi
lnif ~/dotfiles/irssi ~/.irssi
success "Irssi config linked"
# }}}

# Ack {{{
backup ~/.ackrc
lnif ~/dotfiles/ack/ackrc ~/.ackrc
success "Ack config linked"
# }}}

# Emacs {{{
backup ~/.emacs
lnif ~/dotfiles/emacs/emacs ~/.emacs
success "Emacs config linked"
# }}}

# ZFS {{{
backup ~/bin/destroy-zfs-auto-snaps
lnif ~/dotfiles/zfs/destroy-zfs-auto-snaps ~/bin
success "ZFS utilities installed"
# }}}

# Vim {{{
backup_dir ~/.vim
backup ~/.vimrc
backup ~/.vimrc.bundles
create_vimlinks "Setting up vim symlinks"
clone_vundle    "Successfully cloned vundle"
setup_vundle    "Now updating/installing plugins using Vundle"
# }}}

# Success {{{
ret="$?"
success "Setup complete!"
# }}}
