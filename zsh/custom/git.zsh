# preferred git shortcuts, not in the git plugin

#compare the provided version of git to the version installed and on path
#prints 1 if input version <= installed version
#prints -1 otherwise
function git_compare_version() {
  local INPUT_GIT_VERSION=$1;
  local INSTALLED_GIT_VERSION
  INPUT_GIT_VERSION=(${(s/./)INPUT_GIT_VERSION});
  INSTALLED_GIT_VERSION=($(command git --version 2>/dev/null));
  INSTALLED_GIT_VERSION=(${(s/./)INSTALLED_GIT_VERSION[3]});

  for i in {1..3}; do
    if [[ $INSTALLED_GIT_VERSION[$i] -gt $INPUT_GIT_VERSION[$i] ]]; then
      echo 1
      return 0
    fi
    if [[ $INSTALLED_GIT_VERSION[$i] -lt $INPUT_GIT_VERSION[$i] ]]; then
      echo -1
      return 0
    fi
  done
  echo 1
  return 0
}
POST_1_8_3_GIT=$(git_compare_version "1.8.3")
unset -f git_compare_version

# As of git 1.8.3 decorations can be coloured automatically according to what
# they are i.e. tags, branches, etc.
if [[ $POST_1_8_3_GIT -gt 0 ]]; then
  DECO_COLOUR='%C(auto)'
else
  DECO_COLOUR='%Cgreen'
fi
GIT_LOG_FORMAT='"format:%C(yellow)%h %Creset%ad %Cblue%an:'$DECO_COLOUR'%d %Creset%s"'

alias ga.='git add -A .'
alias gap='git add -p'
alias gbav='git branch -av'
alias gbd='git branch -D'
alias gbv='git branch -v'
alias gcob='git checkout -b'
alias gds='git diff --staged'
alias gf='git fetch --all --tags && git fetch --all --prune'
alias ggpush='git push -u origin $(current_branch)'
compdef ggpush=git
# standard log with train tracks.
alias gl='git log --graph --date=short --pretty='$GIT_LOG_FORMAT
# search through commit DIFFs for particular text (pick ax)
# does NOT search commit MESSAGES - use `--grep` for that.
alias glS='git log -S'
alias gla='gl --all'
# concise branch and tag log with train tracks.
alias glb='gl --simplify-by-decoration'
alias glh='gl --max-count=15'
alias glp='git log --graph --decorate --patch'
alias gls='git log --graph --decorate --stat'
alias gr='git reset'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias gs='git status'
# git submodule management
alias gsm='git submodule'
alias gsmpull='git submodule foreach git pull'
alias gsmup='git submodule sync && git submodule update --init'
# useful for finding parent commit for a given commit hash
alias gsr='git show --format=raw'
# fix tracking for origin if not there.
alias track='git branch --set-upstream-to origin/$(current_branch) && git fetch'
# autosquashing for simple fixups.
alias grbi='git rebase -i --autosquash'
alias gcf='git commit --fixup'
alias gcs='git commit --squash'

# useful omz git plugin ones include:
#   ga, gc, gco, gb, gba, gm, grhh, grb, gwip, gunwip
#
# ggpush has been removed from oh-my-zsh!
# ggpush translates into `git push origin <current branch>`.

# Recover indexed/staged changes that were lost.
#
# By a careless reset, for example. This function locates all dangling/orphaned
# blobs and puts them in text files. These files can then be checked for the
# lost changes.
#
# Most tidy method found so far:
# http://blog.ctp.com/2013/11/21/git-recovering-from-mistakes/
function git_retrieve_discarded_index_changes() {
  for blob in $(git fsck --lost-found | awk '$2 == "blob" { print $3 }'); do
    git cat-file -p $blob > $blob.txt;
  done
}
