## Set tab title to hostname
print -Pn "\e]1;`hostname | cut -d. -f1`\a"

## Multiline Prompt
PROMPT='
%{$fg[cyan]%}[%m]  %{$fg[yellow]%}%3~  $(git_prompt_info)
%{$fg[magenta]%}%n → %{$reset_color%}'
RPROMPT='$(vi_mode_prompt_info) %{$reset_color%}%T %{$fg[white]%}%h%{$reset_color%}'

MODE_INDICATOR="%{$fg[green]%}vi-mode%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}"
ZSH_THEME_GIT_STATUS_MAX=20
ZSH_THEME_GIT_PROMPT_UNMERGED="U"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
ZSH_THEME_GIT_TREE_MODIFIED="+"
ZSH_THEME_GIT_TREE_DELETED="x"
ZSH_THEME_GIT_INDEX_MODIFIED="+"
ZSH_THEME_GIT_INDEX_ADDED="±"
ZSH_THEME_GIT_INDEX_DELETED="x"
ZSH_THEME_GIT_INDEX_RENAMED="r"
ZSH_THEME_GIT_INDEX_COPIED="c"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" BEHIND"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" AHEAD"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=" %{$fg[red]%}DIVERGED!"

##############################
# FUNCTIONS
##############################

# Display Git repo information in prompt (override the default omz function)
#
# Displays [repo_name:branch_name:commit_sha] MERGE/BISECT/REBASE x+changes+x
#
# Git commit id and mode code taken from:
# https://github.com/benhoskings/dot-files/blob/master/files/bin/git_cwd_info
function git_prompt_info() {
  GIT_REPO_PATH=$(git rev-parse --git-dir 2>/dev/null)
  [[ $GIT_REPO_PATH == "" ]] && return

  GIT_COMMIT_ID=`git rev-parse --short HEAD 2>/dev/null`

  GIT_MODE=""
  if [[ -e "$GIT_REPO_PATH/BISECT_LOG" ]]; then
    GIT_MODE=" BISECT"
  elif [[ -e "$GIT_REPO_PATH/MERGE_HEAD" ]]; then
    GIT_MODE=" MERGE"
  elif [[ -e "$GIT_REPO_PATH/rebase" || -e "$GIT_REPO_PATH/rebase-apply" || -e "$GIT_REPO_PATH/rebase-merge" || -e "$GIT_REPO_PATH/../.dotest" ]]; then
    GIT_MODE=" REBASE"
  fi

  GIT_BRANCH=$(current_branch)
  [[ $GIT_BRANCH == '' ]] && GIT_BRANCH="%{$fg[red]%}no branch$(parse_git_dirty)"
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_repository):$GIT_BRANCH:$GIT_COMMIT_ID$ZSH_THEME_GIT_PROMPT_SUFFIX%{$fg[magenta]%}$GIT_MODE$(git_remote_status)$(git_prompt_status)"
}


# Git Change Indication (overriding default omz function)
#
# Prints symbol for each change instead of just indicating if change type exists.
# This gives a better visual sense of how much has changed.
#
# TODO If you find prompt speed slow, it's because of this section.
# The limitation is the speed of `git status` in any given repo (it's slower
# than you'd imagine).
# This can be countered somewhat by ignoring submodules. We lose reporting of
# submodule changes in prompt, but the speed is much better.
# The rest of the status string building is near-instantaneous.
git_prompt_status() {
  local SUBMODULE_SYNTAX=''
  [[ $POST_1_7_2_GIT -gt 0 ]] && SUBMODULE_SYNTAX="--ignore-submodules=dirty"
  INDEX=$(git status --porcelain $SUBMODULE_SYNTAX 2> /dev/null)
  [[ -z $INDEX ]] && return
  X_SET=""
  Y_SET=""
  UN_SET=""
  echo $INDEX | while IFS= read LINE; do
    X=$LINE[1]
    Y=$LINE[2]
    [[ $X$Y == '??' ]] && UN_SET="$UN_SET$ZSH_THEME_GIT_PROMPT_UNTRACKED" && continue
    [[ $X == 'U' ]] || [[ $Y == 'U' ]] && UN_SET="$UN_SET$ZSH_THEME_GIT_PROMPT_UNMERGED" && continue
    [[ $X$Y == 'DD' ]] || [[ $X$Y == 'AA' ]] && UN_SET="$UN_SET$ZSH_THEME_GIT_PROMPT_UNMERGED" && continue
    [[ $Y == 'M' ]] && Y_SET="$Y_SET$ZSH_THEME_GIT_TREE_MODIFIED"
    [[ $Y == 'D' ]] && Y_SET="$Y_SET$ZSH_THEME_GIT_TREE_DELETED"
    [[ $X == 'M' ]] && X_SET="$X_SET$ZSH_THEME_GIT_INDEX_MODIFIED" && continue
    [[ $X == 'A' ]] && X_SET="$X_SET$ZSH_THEME_GIT_INDEX_ADDED" && continue
    [[ $X == 'D' ]] && X_SET="$X_SET$ZSH_THEME_GIT_INDEX_DELETED" && continue
    [[ $X == 'R' ]] && X_SET="$X_SET$ZSH_THEME_GIT_INDEX_RENAMED" && continue
    [[ $X == 'C' ]] && X_SET="$X_SET$ZSH_THEME_GIT_INDEX_COPIED" && continue
  done
  STATUS=" %{$FG[070]%}$X_SET%{$FG[124]%}$Y_SET%{$FG[220]%}$UN_SET"
  echo $STATUS
}

# Read the current repository (override the default omz function)
#
# Cope with non-ssh repos by not relying on ':'. Instead, we look for text
# between a '/' and '.git'.
# TODO should expand to search between '/' and space, if '.git' is not present.
# Some people don't write their remotes properly.
function current_repository() {
  echo $(git remote -v | head -1 | sed 's/.*\/\([^/]*\)\.git.*/\1/')
}
