# Indicate if ZLE is in vicmd mode/keymap.
VIMODE_INDICATOR="$cBold${FG[2]}NORMAL$cReset"
function vimode() {
  # Display indicator if the keymap is 'vicmd', otherwise nothing.
  echo "${${KEYMAP/vicmd/$VIMODE_INDICATOR}/(main|viins)/}"
}

# Refresh the prompt each keymap change, to show/hide the vicmd indicator.
function zle-keymap-select {
  zle reset-prompt # Re-expand the prompts.
  zle -R           # Redisplay the command line.
}
zle -N zle-keymap-select # Special Widget: called when keymap changes.
