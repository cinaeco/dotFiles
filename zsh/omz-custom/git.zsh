# preferred git shortcuts, not in the git plugin

alias ga.='git add .'
alias gap='git add -p'

alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'

alias gcob='git checkout -b'
alias gf='git fetch --tags && git fetch --prune'

alias gbd='git branch -D'

# standard log with train tracks
alias gl='git log --graph --pretty="format:%C(yellow)%h%Cgreen%d %Cblue[%an] %Creset%s... %C(cyan)%ar"'
# concise, branch and tag log with train tracks (some merge commits unavoidable)
alias glb='git log --all --simplify-by-decoration --pretty="format:%C(yellow)%h%Cgreen%d %Cblue[%an] %Creset%s... %C(cyan)%ar"'
alias glp='git log --patch'
# useful when you want to have a visual on file changes
alias gls='git log --graph --stat'
# search through history for particular text
alias glS='git log -S'

alias gr='git reset'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias grb='git rebase'

# useful for finding parent commit for a given commit hash
alias gsr='git show --format=raw'

# git submodule management
alias gsm='git submodule'
alias gsmup='git submodule sync && git submodule update --init'
alias gsmpull='git submodule foreach git pull origin master'

# useful if you forget to setup tracking for a new branch when checking out.
alias track='git branch --set-upstream $(current_branch) origin/$(current_branch) && git fetch'

# useful omz git plugin ones include:
#   ga, gc, gco, gb, gba, gm, grhh, ggpull, ggpush
#
# ggpull translates into `git pull origin <current branch>`, same for ggpush
#
# Note: both the gg's are extremely convenient! And safe, because you never know
# if tracking has been setup properly on a branch.
