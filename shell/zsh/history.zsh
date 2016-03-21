## Command history configuration
HISTSIZE=10000 # Max events stored in the internal history list.
SAVEHIST=10000 # Max events to save to file when interactive shell exits.
[[ -z "$HISTFILE" ]] && HISTFILE=$HOME/.zshhistory

# Show history
#alias history='fc -l 1' # No timestamps
alias history='fc -il 1' # timestamp "yyyy-mm-dd hh:mm"
alias h='history | tail -n 100'

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt inc_append_history
setopt nohistverify # Don't show expansions, just execute, e.g. for !! and !$
setopt nosharehistory # Don't have the same history across tabs/windows
