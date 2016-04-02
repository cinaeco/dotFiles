# Relevant manpages:
# - zshoptions
# - zshcompwid
# - zshcompsys


setopt auto_menu        # show completion menu on succesive tab press.
setopt complete_in_word # Perform completion from both ends of a word.
setopt always_to_end    # Move cursor to end of word after completion.


# Add custom completions from dotfiles to fpath.
fpath=(~/dotfiles/shell/zsh/completions $fpath)


# Load completion functions.
#
# `compinit` - Completion initisation.
# `compaudit` - Finds insecure completion folders (wrong owner, 777) in fpath.
# Used by compinit internally, added here to be called manually.
# `compinstall` - Completion configurator.
autoload -Uz compinit compaudit #compinstall


# Initialise completion.
compinit


# Load zsh module for completion listing extensions.
# Enables extensions for match highlighting, list scrolling and different
# completion menu styles.
zmodload -i zsh/complist


# Colour completion listings.
zstyle ':completion:*' list-colors ''


# Highlight the current completion selection.
zstyle ':completion:*' menu select


# Case-insensitive completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# Use caching so that commands like apt and dpkg complete are useable.
zstyle ':completion::complete:*' use-cache on


# Completion Waiting Dots.
expand-or-complete-with-dots() {
  # Toggle line-wrapping off and back on again.
  [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
  print -Pn "%{$FG[1]......$cReset%}"
  [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam

  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
