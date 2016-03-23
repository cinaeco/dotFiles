bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# Bash completion (https://github.com/scop/bash-completion).
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
  source /etc/bash_completion
elif [[ -n $(command -v brew) && -f $(brew --prefix)/etc/bash_completion ]]; then
  source $(brew --prefix)/etc/bash_completion
fi
