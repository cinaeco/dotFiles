# Relevant manpages:
# - zshzle - binding, widgets
# - zshbuiltins - autoload
# - zshmodules - echoti, $terminfo
# - terminfo - "smkx" and "rmkx"


# Use vi-bindings in ZLE (Zsh Line Editor) for command editing.
bindkey -v


# <S-Tab> to cycle backwards through autocomplete suggestions.
bindkey '^[[Z' reverse-menu-complete


# Command line editing with text editor: `v` in vi-command mode or `<C-x><C-e>`.
#
# Load a function from an fpath folder. e.g. /usr/share/zsh/*/functions.
autoload -Uz edit-command-line
zle -N edit-command-line
# `-N` creates a New user-defined widget that fires a function. In this case,
# since no function is given, the widget will fire a function of the same name.
bindkey '\C-x\C-e' edit-command-line # Bind the widget to keys.
bindkey -M vicmd v edit-command-line # Same, but only for the `vicmd` keymap.


# Make Ctrl-z also bring jobs back to the foreground.
fancy-ctrl-z () {
  # Push current input into an input stack. Gets popped when ZLE next opens
  # e.g. at next <C-z>, or when foreground jobs finishes.
  [[ $#BUFFER -ne 0 ]] && zle push-input
  # Bring last job back to foreground
  BUFFER="fg"
  zle accept-line
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z


# Key bindings for history search
#
# [Up & Down Arrow] - search through history for the current input string.
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  bindkey "${terminfo[kcuu1]}" up-line-or-search
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
  bindkey "${terminfo[kcud1]}" down-line-or-search
fi
# [Ctrl-r] - Search backward incrementally for a specified string.
bindkey '^r' history-incremental-search-backward


# If a terminal supports it, make sure to enter `keyboard_transmit` mode when
# zle is active, since only then are values from `$terminfo` valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx # Set the terminal into `keyboard_transmit` mode
  }
  function zle-line-finish() {
    echoti rmkx # Leave `keyboard_transmit` mode
  }
  zle -N zle-line-init   # Special Widget: runs before each new line of input.
  zle -N zle-line-finish # Special Widget: runs after input has been read.
fi


# Leaving this here because OMZ uses it without explanation, and it took some
# experimentation to find out why. This setting affects what emacs keybindings
# (e.g. M-b and M-f) consider a word. Setting this to an empty string means that
# motions would stop at all non-alphanumeric characters. This is irrelevant for
# vi keybindings which employ the concepts of "words" and "WORDS".
#WORDCHARS=''
