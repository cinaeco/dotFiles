# Display git repo information in a shell prompt
#
# Format:
#
#     [repo:branch:commit] BARE BISECT/MERGE/REBASE NO-REMOTE/NO-RTB/AHEAD/BEHIND/DIVERGED WIP STASH +±xcru?
#
# Usage:
#
# Call `__gitp` in such a way that prompt expansion happens i.e. from bash's
# `PROMPT_COMMAND` or zsh's `PROMPT`/`pre_cmd()`.
#
function __gitp() {
  # Preserve the exit status of the previous command.
  local exit=$?

  # Only run if git exists.
  [[ -z $(command -v git) ]] && return $exit

  # Try to get git info. Also serves to check if current folder is a git repo.
  local gitinfo ret
  gitinfo=$(git rev-parse \
    --git-dir \
    --is-bare-repository \
    --is-inside-work-tree \
    --short HEAD 2>/dev/null)
  ret="$?"
  [[ -z $gitinfo ]] && return $exit

  # Explode git info into individual variables.
  local gitdir=${gitinfo%%$'\n'*}; gitinfo=${gitinfo#*$'\n'}
  local bare=${gitinfo%%$'\n'*}; gitinfo=${gitinfo#*$'\n'}
  local worktree=${gitinfo%%$'\n'*}; gitinfo=${gitinfo#*$'\n'}
  local commit; [[ $ret = "0" ]] && commit=$gitinfo

  __gitp_cprep

  # Prepare display elements.
  [[ $bare = 'true' ]] && bare=${GITP_BARE:-"$cRed BARE"} || bare=''
  local location="$(__gitp_location $commit)"
  if [[ $worktree = 'true' ]]; then
    # Many things only matter if in a work tree (i.e. not bare, not in gitdir).
    __gitp_status
    local op="$(__gitp_op $gitdir)"
    local remote="$(__gitp_remote)"
    local wips="$(__gitp_wips $gitdir)"
    local changes="$(__gitp_changes)"
  fi
  # Colour the location if there are local changes.
  local dirty=$(__gitp_dirty)

  # Display the git prompt.
  local formatting=${1:-' %s'}
  printf -- "$formatting" "$dirty$location$bare$op$remote$wips$changes"
  return $exit
}

# Get git status output for parsing.
function __gitp_status() {
  GITP_STATUS=''

  # Ignore work tree changes in submodules to speed up prompt rendering.
  GITP_STATUS=$(git status --porcelain --ignore-submodules=dirty 2>/dev/null) \
    || GITP_STATUS=$(git status --porcelain)
}

# Initialise colour strings.
function __gitp_cprep() {
  if [[ -n ${BASH_VERSION-} ]]; then
    cStart=${cStart:-'\[\e['}
    cEnd=${cEnd:-'m\]'}
  elif [[ -n ${ZSH_VERSION-} ]]; then
    cStart=${cStart:-'%{['}
    cEnd=${cEnd:-'m%}'}
  fi
  cReset=${cReset:-$cStart'0'$cEnd}
  cRed=$cStart'38;5;1'$cEnd
  cGre=$cStart'38;5;2'$cEnd
  cBlu=$cStart'38;5;4'$cEnd
  cMag=$cStart'38;5;5'$cEnd
  cgGre=$cStart'38;5;70'$cEnd
  cgRed=$cStart'38;5;124'$cEnd
  cgYel=$cStart'38;5;220'$cEnd
}

# Get location i.e. which repo/branch/commit is this?
function __gitp_location() {
  local prefix=${GITP_PREFIX:-'['}
  local suffix=${GITP_SUFFIX:-"]"}
  local repo=$(__gitp_repo)
  local branch=$(__gitp_branch)
  [[ -z $branch ]] && branch=$(git describe --tags --exact-match 2>/dev/null)
  echo "$prefix$repo:$branch:$1$suffix"
}

# Determine if a repo is in the middle of an "operation" e.g. rebase, bisect.
function __gitp_op() {
  local bisect=${GITP_BISECT:-"$cRed BISECT"}
  local  merge=${GITP_MERGE:-"$cRed MERGE"}
  local rebase=${GITP_REBASE:-"$cRed REBASE"}
  local op

  if [[ -e "$1/BISECT_LOG" ]]; then
    op+="$bisect"
  elif [[ -e "$1/MERGE_HEAD" ]]; then
    op+="$merge"
  elif [[ -e "$1/rebase" || -e "$1/rebase-apply" ||  -e "$1/rebase-merge" || -e "$1/../.dotest" ]]; then
    op+="$rebase"
  fi
  echo "$op"
}

# Compare the local and remote tracking branches (upstream).
function __gitp_remote() {
  local noremote=${GITP_NOREMOTE:-"$cMag NO-REMOTE"}
  local    nortb=${GITP_NORTB:-"$cMag NO-RTB"}
  local    ahead=${GITP_AHEAD:-"$cMag AHEAD"}
  local   behind=${GITP_BEHIND:-"$cMag BEHIND"}
  local diverged=${GITP_DIVERGED:-"$cRed DIVERGED"}
  local remote commits count ahd=0 bhd=0

  # Count commits ahead and behind.
  if commits="$(git rev-list --left-right @{upstream}...HEAD 2>/dev/null)"; then
    [[ -n ${ZSH_VERSION-} ]] && commits=(${(f)commits})
    for commit in $commits; do
      case "$commit" in
        "<"*) ((bhd++)) ;;
        *)    ((ahd++)) ;;
      esac
    done
    count="$bhd  $ahd"
  fi

  # Determine what to display.
  case "$count" in
    "") # no upstream
    if [[ -z "$(git remote -v)" ]]; then
      remote="$noremote"
    elif [[ -n "$(__gitp_branch)" ]]; then
      remote="$nortb"
    fi
    ;;
    "0  0") ;;                       # Equal to upstream.
    "0  "*) remote="$ahead-$ahd" ;;  # Ahead of upstream.
    *"  0") remote="$behind-$bhd" ;; # Behind upstream.
    *)      remote="$diverged" ;;    # Diverged from upstream.
  esac

  echo "$remote"
}

# Warn if the current commit is a work-in-progress or if there are stashed
# changes.
#
# WIP commits are made with `gwip` and removed with `gunwip`.
function __gitp_wips() {
  local wip=${GITP_WIP:-"$cRed WIP"}
  local stash=${GITP_STASH:-"$cRed STASH"}
  local wips

  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    wips="$wip"
  fi

  [[ -e "$1/refs/stash" ]] && wips+="$stash"

  echo "$wips"
}

# Work tree change indicators
#
# Prints symbol for each change in `git status`, up to the number of symbols
# indicated by `GITP_CHANGES_MAX`. Gives a good visual of what has changed.
#
# Performance note: if the git prompt is slow, it is more because `git status`
# is slow. Change-string building is near-instantaneous since it is just string
# manipulation.
function __gitp_changes() {
  [[ -z $GITP_STATUS ]] && return

  local changes_max=${GITP_CHANGES_MAX:-20}
  local       i_col=${GITP_COLOUR_INDEX:-$cgGre}
  local       w_col=${GITP_COLOUR_WTREE:-$cgRed}
  local       u_col=${GITP_COLOUR_UN:-$cgYel}
  local       e_col=${GITP_COLOUR_END:-$cReset}
  local lines line X Y x_set y_set u_set end count=0

  # Split git status by newline into array elements.
  if [[ -n ${BASH_VERSION-} ]]; then
    IFS=$'\n'
    lines=$GITP_STATUS
  elif [[ -n ${ZSH_VERSION-} ]]; then
    lines=(${(f)GITP_STATUS})
  fi

  for line in $lines; do
    (( count+=1 ))
    (( count >= $changes_max )) && end='..' && break
    X=${line:0:1}
    Y=${line:1:1}
    [[ $X$Y = '??' ]] && u_set+="?" && continue
    [[ $X = 'U' ]] || [[ $Y = 'U' ]] && u_set+="u" && continue
    [[ $X$Y = 'DD' ]] || [[ $X$Y = 'AA' ]] && u_set+="u" && continue
    [[ $Y = 'M' ]] && y_set+="+"
    [[ $Y = 'D' ]] && y_set+="x"
    [[ $X = 'M' ]] && x_set+="+" && continue
    [[ $X = 'A' ]] && x_set+="±" && continue
    [[ $X = 'D' ]] && x_set+="x" && continue
    [[ $X = 'R' ]] && x_set+="r" && continue
    [[ $X = 'C' ]] && x_set+="c" && continue
  done

  [[ -n ${BASH_VERSION-} ]] && unset IFS

  echo " $i_col$x_set$w_col$y_set$u_col$u_set$e_col$end$cReset"
}

# Check if a repo is modified
function __gitp_dirty() {
  local clean=${GITP_CLEAN:-$cReset$cGre}
  local dirty=${GITP_DIRTY:-$cReset$cBlu}
  [[ -z $GITP_STATUS ]] && echo "$clean" || echo "$dirty"
}

# Get repository name
#
# Check for a name in git remotes, between ':' or '/' and a space.
function __gitp_repo() {
  local repo="$(git remote -v | head -n 1 2> /dev/null)"
  repo=${repo##*[:|/]}
  repo=${repo% *}
  printf "${repo%.git}"
}

# Get current branch name
#
# Prints the branch name or tag of the current commit, if any.
function __gitp_branch() {
  local ref
  ref=$(git symbolic-ref --quiet HEAD 2>/dev/null)
  printf "${ref#refs/heads/}"
}
