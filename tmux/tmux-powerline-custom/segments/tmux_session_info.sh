#!/usr/bin/env sh
# Prints tmux session info.
# Assuems that [ -n "$TMUX"].
tmux display-message -p 'Session: [#S]'

exit 0
