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

alias gs='git status'
alias gds='git diff --staged'

alias gcob='git checkout -b'
alias gf='git fetch --all --tags && git fetch --all --prune'

alias gbd='git branch -D'
alias gbv='git branch -v'
alias gbav='git branch -av'

# standard log with train tracks
alias gl='git log --graph --date=short --pretty='$GIT_LOG_FORMAT
alias gla='gl --all'
# concise, branch and tag log with train tracks (some merge commits unavoidable)
alias glb='gl --simplify-by-decoration'
alias glh='gl --max-count=15'
alias glp='git log --graph --decorate --patch'
# useful when you want to have a visual on file changes
alias gls='git log --graph --decorate --stat'
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
