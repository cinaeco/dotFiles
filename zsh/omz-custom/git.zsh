## preferred git shortcuts not in the git plugin
#
alias ga.='git add .'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'

alias gcob='git checkout -b'
alias gf='git fetch'

alias gbd='git branch -D'

## standard log with train tracks
alias gl='git log --graph --pretty="format:%C(yellow)%h %Cblue[%an] %Creset%s...%C(cyan)%ar%Cgreen%d"'
## concise, branch-only log with train tracks
alias glb='git log --graph --all --simplify-by-decoration --pretty="format:%C(yellow)%h %Cblue[%an] %Creset%s... %C(cyan)%ar%Cgreen%d"'
## search through history for particular text
alias glS='git log -S'
alias glp='git log --patch'
alias gls='git log --graph --stat'

alias grb='git rebase'
alias grh='git reset --hard'
alias grs='git reset --soft'

alias gsr='git show --format=raw'

alias track='git branch --set-upstream $(current_branch) origin/$(current_branch) && git fetch'

# useful git plugin built-in ones include:
#   ga, gc, gco, gb, gba, gm, grhh, ggpull, ggpush
# ggpull translates into `git pull origin <current branch>`, same for ggpush
