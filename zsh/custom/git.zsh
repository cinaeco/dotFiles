# Git version string
GIT_VERSION=$(git --version 2> /dev/null)
GIT_VERSION=${GIT_VERSION:12}

# Prepare compact git log (`gl`) format
#
# Log displays train tracks, decorations, users and dates.
if [[ $(version-compare $GIT_VERSION "1.8.3") -ge 0 ]]; then
  DECO_COLOUR='%C(auto)'
else
  DECO_COLOUR='%Cgreen'
fi
GIT_LOG_PRETTY="'format:%C(yellow)%h %Creset%ad %Cblue%an:$DECO_COLOUR%d %Creset%s'"
GIT_LOG_DEFAULTS="--graph --date=short --pretty=$GIT_LOG_PRETTY"

# Useful oh-my-zsh git plugin aliases:
#
#     ga, gc, gco, gb, gba, gm, grhh, grb/grba/grbc, gwip, gunwip
#
# Aliases not in the git plugin:
alias ga.='git add -A .'
alias gap='git add -p'
alias gbav='git branch -av'
alias gbd='git branch -D'
alias gbv='git branch -v'
alias gcob='git checkout -b'
alias gcop='git checkout -p'
alias gds='git diff --staged'
alias gf='git fetch --all --tags && git fetch --all --prune'
alias ggpush='git push -u origin $(current_branch)'
alias gl="git log $GIT_LOG_DEFAULTS"
alias gla='gl --all' # show all refs, not only those reachable from current branch.
alias glb='gl --simplify-by-decoration' # show mostly branches and tags.
alias glh="git --no-pager log --max-count=15 $GIT_LOG_DEFAULTS" # show first few.
alias glp='git log --graph --decorate -p'
alias gls='git log --graph --decorate --stat'
alias gr='git reset'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias gs='git status'
alias gsr='git show --format=raw' # all info about a commmit.

# Searching history.
alias glG='git log --stat -G' # Search DIFFS - changes with given text.
alias glS='git log --stat -S' # Search DIFFS - changes in number of given text.
alias glg='git log --grep' # Search MESSAGES.

# Submodule management.
alias gsm='git submodule'
alias gsmpull='git submodule foreach git pull origin master'
alias gsmup='git submodule sync && git submodule update --init --recursive'

# Fix tracking for origin if not there.
alias track='git branch --set-upstream-to origin/$(current_branch) && git fetch'

# Autosquashing for simple fixups.
alias grbi='git rebase -i --autosquash'
alias gcf='git commit --fixup'
alias gcs='git commit --squash'

# Recover indexed/staged changes that were lost.
#
# By a careless reset, for example. This function locates all dangling/orphaned
# blobs and puts them in text files. These files can then be checked for the
# lost changes. http://blog.ctp.com/2013/11/21/git-recovering-from-mistakes/
function git_retrieve_discarded_index_changes() {
  for blob in $(git fsck --lost-found | awk '$2 == "blob" { print $3 }'); do
    git cat-file -p $blob > $blob.txt;
  done
}
