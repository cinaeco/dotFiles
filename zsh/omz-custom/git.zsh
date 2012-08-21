## preferred git shortcuts not in the git plugin
#
alias ga.='git add .'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'

alias gcob='git checkout -b'
alias gf='git fetch'

alias gbd='git branch -D'

alias gl='git log --graph --date=relative --pretty="format:%C(yellow)%h %Cblue[%cn] %Creset%s... %cd"'
alias gls='git log --graph --stat'
alias glp='git log -p'

alias gr='git rebase'

alias gtrack='git branch --set-upstream $(current_branch) origin/$(current_branch) && git fetch'

# useful git plugin built-in ones include:
#   ga, gc, gco, gb, gba, gm, grhh, ggpull, ggpush
# ggpull translates into `git pull origin <current branch>`, same for ggpush
