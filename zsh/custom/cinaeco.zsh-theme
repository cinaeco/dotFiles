## Set tab title to hostname
print -Pn "\e]1;`hostname | cut -d. -f1`\a"

## Multiline Prompt
PROMPT='
$(host_name)$(current_folder)$(git_prompt_info)$(background_job_info)
%{$fg[magenta]%}%n - %{$reset_color%}'
RPROMPT='$(vi_mode_prompt_info) %{$reset_color%}%T %{$fg[white]%}%h%{$reset_color%}'

MODE_INDICATOR="%{$fg[green]%}vi-mode%{$reset_color%}"

ZSH_THEME_GIT_PROMPT="on"
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
DISABLE_UNTRACKED_FILES_DIRTY="false"

##############################
# FUNCTIONS
##############################

function host_name() {
  echo "%{$fg[cyan]%}[%m]"
}

function current_folder() {
  echo "  %{$fg[yellow]%}%3~"
}

function background_job_info() {
  echo "  %(1j.%{$FG[063]%}[jobs]: %{$fg[red]%}%j%{$reset_color%}.)"
}

# Toggle the display of git information in the prompt. Defaults to "on".
function toggle_git_prompt() {
  [[ $ZSH_THEME_GIT_PROMPT == "on" ]] && ZSH_THEME_GIT_PROMPT="off" || ZSH_THEME_GIT_PROMPT="on"
}

# Set Up List of Git Status Indicators
#
# This function retrieves a porcelain `git status` for use in other functions,
# `git_prompt_status` and `parse_git_dirty`.
function get_git_status() {
  local FLAGS
  FLAGS=("--porcelain")
  [[ $POST_1_7_2_GIT -gt 0 ]] && FLAGS+="--ignore-submodules=dirty"
  [[ $DISABLE_UNTRACKED_FILES_DIRTY == "true" ]] && FLAGS+="--untracked-files=no"
  INDEX=$(git status $FLAGS 2> /dev/null)
}

# Display Git repo information in prompt (override the default omz function)
#
# Displays [repo:branch:commit] BISECT/MERGE/REBASE AHEAD/BEHIND/DIVERGED! +±xcrU?
#
# Git commit id and mode code taken from:
# https://github.com/benhoskings/dot-files/blob/master/files/bin/git_cwd_info
function git_prompt_info() {
  [[ $ZSH_THEME_GIT_PROMPT == "off" ]] && return
  local GIT_REPO_PATH=$(git rev-parse --git-dir 2>/dev/null)
  [[ $GIT_REPO_PATH == "" ]] && return

  local GIT_COMMIT_ID=`git rev-parse --short HEAD 2>/dev/null`

  local GIT_MODE="%{$fg[magenta]%}"
  if [[ -e "$GIT_REPO_PATH/BISECT_LOG" ]]; then
    GIT_MODE="$GIT_MODE BISECT"
  elif [[ -e "$GIT_REPO_PATH/MERGE_HEAD" ]]; then
    GIT_MODE="$GIT_MODE MERGE"
  elif [[ -e "$GIT_REPO_PATH/rebase" || -e "$GIT_REPO_PATH/rebase-apply" || -e "$GIT_REPO_PATH/rebase-merge" || -e "$GIT_REPO_PATH/../.dotest" ]]; then
    GIT_MODE="$GIT_MODE REBASE"
  fi

  local GIT_STASH=""
  if [[ -e "$GIT_REPO_PATH/refs/stash" ]]; then
    GIT_STASH=" %{$fg[red]%}STASH"
  fi

  get_git_status

  echo "  $(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_repository):$(current_branch):$GIT_COMMIT_ID$ZSH_THEME_GIT_PROMPT_SUFFIX$GIT_MODE$(git_remote_status)$GIT_STASH$(git_prompt_status)"
}

# Git Change Indication (overriding default omz function)
#
# Prints symbol for each change instead of just indicating if change type exists.
# This gives a better visual sense of how much has changed.
#
# As big as it looks, this function's status-string building is
# near-instantaneous. It's just string manipulation after all.
#
# If you find prompt speed slow, it's because of the speed of `git status` in
# any given repo: it's slower than you'd imagine.
function git_prompt_status() {
  [[ -z $INDEX ]] && return
  local X
  local Y
  local X_SET=""
  local Y_SET=""
  local UN_SET=""
  local END=""
  local COUNT=0
  echo $INDEX | while IFS= read LINE; do
    ((COUNT+=1))
    ((COUNT >= 20)) && END="%{$reset_color%}..." && break
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
  local STATUS=" %{$FG[070]%}$X_SET%{$FG[124]%}$Y_SET%{$FG[220]%}$UN_SET$END"
  echo $STATUS
}

# Read the current repository (override the default omz function)
#
# Cope with non-ssh repos by not relying on ':'. Instead, we look for text
# between a '/' and whitespace. '.git' is removed.
function current_repository() {
  local repo=$(git remote -v | head -1 | sed 's/.*\/\([^/]*\)\ .*/\1/')
  echo ${repo%.git}
}

# Check if a repo is modified (override the default omz function)
#
# This function is modifed to no longer run `git status`, and to instead rely on
# the output of the single invocation in `get_git_status`. This way, we
# hopefully reduce the time taken to produce a prompt in messy repos.
parse_git_dirty() {
  if [[ -n $INDEX ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}
