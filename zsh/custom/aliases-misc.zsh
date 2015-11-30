# Hosts file
alias hosts='sudo vim /etc/hosts'

# Common places
alias cd.='cd ~/dotfiles'

# Serial console access ("call up line"). Type `~.` (and wait) to disconnect.
alias cul='sudo cu -s 9600 -l'
compdef _cu cul

# Folder listing/traversal, least to most detailed
alias l='ls'
alias la='ls -A'
alias lal='ls -Alh'
