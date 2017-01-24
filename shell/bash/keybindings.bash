# Maybe use vi-bindings in readline for command editing
[[ $VI_MODE = 1 ]] && set -o vi

# Stop readline from auto-binding some control characters (e.g. ctrl-w) so that
# they can be reassigned as desired.
bind 'set bind-tty-special-chars off'

# Set Ctrl-w to delete by word boundaries instead of to the previous space.
bind '\C-w:backward-kill-word'

# Set Ctrl-l to clear the screen. (Enforced as vi-mode does not set this)
bind '\C-l:clear-screen'

# Search history for the current input string.
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
