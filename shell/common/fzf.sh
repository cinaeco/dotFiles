# Fuzzy Finder in Go/Ruby

if [[ -x $(command -v ag 2> /dev/null) ]]; then
  # Setting ag as the default source for fzf
  export FZF_DEFAULT_COMMAND='ag -l -g ""'
else
  # Otherwise at least use `git ls-tree` if available.
  export FZF_DEFAULT_COMMAND='
  (git ls-tree -r --name-only HEAD ||
    find * -name ".*" -prune -o -type f -print -o -type l -print) 2> /dev/null'
fi

# To apply the command to CTRL-T as well (paste selection into command line)
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
