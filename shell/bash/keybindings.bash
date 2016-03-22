# Use vi-bindings in readline for command editing
set -o vi

# Set Ctrl-w to delete by word boundaries instead of to the previous space.
bind 'set bind-tty-special-chars off'
bind '\C-w:backward-kill-word'
