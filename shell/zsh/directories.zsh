# Automatic directory changing e.g. `..` = `cd ..`
setopt auto_cd

# Multiple directory returns. Usable anywhere in command input (-g).
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# Automatic directory stack population.
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
