# Serial console access ("call up line"). Type `~.` (and wait) to disconnect.
alias cul='sudo cu -s 9600 -l'
compdef _cu cul
