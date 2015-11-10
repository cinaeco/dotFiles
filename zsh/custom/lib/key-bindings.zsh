# Overridden keybindings to have up arrow history matching and vi-mode.
#
# vi-mode plugin and oh-my-zsh's key-binding library don't match well, because
# of the way `bindkey -v` overrides previously made bindings.
#
# Unfortunately, there is no nice way to reconcile the two, so parts of both
# have been extracted and placed here.

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# From vi-mode: needed to get prompt indicator to work in `cinaeco.zsh-theme`
function zle-keymap-select {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi

  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select

# Start with vim bindings
bindkey -v

# Key bindings for history search
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.

if [[ "${terminfo[kcuu1]}" != "" ]]; then
  bindkey "${terminfo[kcuu1]}" up-line-or-search      # start typing + [Up-Arrow] - fuzzy find history forward
fi

if [[ "${terminfo[kcud1]}" != "" ]]; then
  bindkey "${terminfo[kcud1]}" down-line-or-search    # start typing + [Down-Arrow] - fuzzy find history backward
fi

# <S-Tab> to tab backwards through autocomplete suggestions.
bindkey '^[[Z' reverse-menu-complete

# Toggle Command Line Editing with <C-x><C-e>, like bash.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
