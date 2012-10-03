# Don't suggest corrections for these commands, in inclusion to omz's defaults
alias cp='nocorrect cp'
alias mv='nocorrect mv'
alias ln='nocorrect ln'
alias touch='nocorrect touch'

# Stop zsh from completing with characters mid-word i.e. y completes to weiyi
# I have found mid-word completion to be quite useful, so this is just here for
# reference.
# zstyle ':completion:*' matcher-list ''
