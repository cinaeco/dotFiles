# Coloured output for ls
if [[ -n $(command -v dircolors) ]]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
elif [[ $(uname -s) = Darwin ]]; then
  alias ls='ls -G'
fi

# Folder listing/traversal
alias l='ls'
alias la='ls -A'
alias ll='ls -lh'
alias lal='ls -Alh'
