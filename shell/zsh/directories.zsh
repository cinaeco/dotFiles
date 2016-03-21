alias md='mkdir -p'
alias rd=rmdir

# Multiple directory returns. Usable anywhere in command (-g).
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# Automatic directory stack population.
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Aliases for using the directory stack.
alias d='dirs -v | head -10'
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# Manually use the directory stack.
alias pu='pushd'
alias po='popd'
