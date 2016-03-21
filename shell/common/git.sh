# Git Aliases (mostly mnemonic)

alias ga.='git add -A .'
alias ga='git add'
alias gap='git add -p'
alias gb='git branch'
alias gba='git branch -a'
alias gbav='git branch -av'
alias gbd='git branch -D'
alias gbv='git branch -v'
alias gc='git commit -v'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcop='git checkout -p'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch --all --tags && git fetch --all --prune'
alias ggpush='git push -u origin $(__gitp_branch)'
alias gm='git merge'
alias gr='git reset'
alias grh='git reset --hard'
alias grhh='git reset HEAD --hard'
alias grs='git reset --soft'
alias grv='git remote -v'
alias gs='git status'
alias gsr='git show --format=raw' # all info about a commmit.

# Git log (`gl`). Displays graph, decorations, users and dates.
[[ $(version-compare $GIT_VER "1.8.3") -ge 0 ]] && DECO_COLOUR='%C(auto)' || DECO_COLOUR='%Cgreen'
GL_PRETTY="'format:%C(yellow)%h %Creset%ad %Cblue%an:$DECO_COLOUR%d %Creset%s'"
GL_OPTS="--graph --date=short --pretty=$GL_PRETTY"
alias gl="git log $GL_OPTS"
alias gla='gl --all' # show all refs, not only those reachable from current branch.
alias glb='gl --simplify-by-decoration' # show mostly branches and tags.
alias glh="git --no-pager log --max-count=15 $GL_OPTS" # show first few (head)
alias glp='git log --graph --decorate -p'
alias gls='git log --graph --decorate --stat'

# Searching history.
alias glG='git log --stat -G' # Search DIFFS - changes with given text.
alias glS='git log --stat -S' # Search DIFFS - changes in number of given text.
alias glg='git log --grep' # Search MESSAGES.

# Submodule management.
alias gsm='git submodule'
alias gsmpull='git submodule foreach git pull origin master'
alias gsmup='git submodule sync && git submodule update --init --recursive'

# Fix tracking for origin if not there.
alias track='git branch --set-upstream-to origin/$(__gitp_branch) && git fetch'

# Autosquashing for simple fixups.
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i --autosquash'
alias gcf='git commit --fixup'
alias gcs='git commit --squash'

# Create Work-In-Progress commits.
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "--wip--"'
