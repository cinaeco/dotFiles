# Standardize location of the ssh-agent authentication socket.
# Perform automatic ssh-agent starting and key-loading as necessary.
#
# The `SSH_AUTH_SOCK` variable allows users interact with ssh-agent loaded
# identities. Having this socket linked to a predictable place means a given
# user can expect loaded identities to persist:
#  - in tmux, screen and similar multiplexers
#  - through `sudo su`/`su` to root (BUT NOT with '-' which clears envvars)

# The `ID_FILES` variable contains the standard identity files that ssh-add
# tries to load. The value can be overridden by simply declaring an alternate
# array before this script is run i.e. near the top of bashrc/zshrc.
ID_FILES=(${ID_FILES[@]:-~/.ssh/id_rsa ~/.ssh/id_dsa ~/.ssh/id_ecdsa ~/.ssh/identity})

function agent_setup() {
  # Try to reach an existing socket.
  linksocket

  # If that does not work, try to reach the socket of the sudo user.
  if ! agent_available; then
    linksocket_sudo
  fi

  # If nothing worked, a no valid socket is found. If there are any identities
  # available, create a new agent.
  if ! agent_available && ids_available; then
    start_sshagent
    linksocket
  fi

  # If the agent is empty, add identities with the default file names.
  if ! ids_loaded && ids_available; then
    ssh-add $ID_FILES 2> /dev/null
  fi

  # The End
}

# Start a new ssh-agent process.
function start_sshagent() {
  echo "Starting a new SSH Agent."
  eval `ssh-agent` &> /dev/null
}

# Link up an existing socket to the expected location if it is not already.
#
# Also, if the socket in the environment is a symlink, try to get to the actual
# socket itself.
function linksocket() {
  local link="/tmp/ssh-agent-$USER-tmux"
  if [[ ! -z $SSH_AUTH_SOCK && $SSH_AUTH_SOCK != $link ]]; then
    local target=$SSH_AUTH_SOCK
    [[ -L $SSH_AUTH_SOCK ]] && target=`readlink $SSH_AUTH_SOCK`
    [[ -e $target ]] && ln -sf $target $link &> /dev/null
  fi
  export SSH_AUTH_SOCK=$link
}

# If we detect sudo, try to link the current user (usually root) to the sudo
# user's socket directly
#
# A user cannot access another user's socket using a symlink, even if that user
# has super privileges. They can, however reach that socket directly, so a
# personal symlink is attempted.
function linksocket_sudo() {
  local linksudo="/tmp/ssh-agent-$SUDO_USER-tmux"
  if [[ ! -z $SUDO_USER && -L $linksudo ]]; then
    local link="/tmp/ssh-agent-$USER-tmux"
    ln -sf `readlink $linksudo` $link &> /dev/null
    export SSH_AUTH_SOCK=$link
  fi
}

# Check if there is a usable ssh-agent.
#
# `ssh-add`'s return value `2` means it was unable to contact an agent.
# Return values:
#   0 = success, agent contacted.
#   1 = failed to connect to an agent.
function agent_available() {
  ssh-add -l &> /dev/null
  [[ $? -eq 2 ]] && return 1 || return 0
}

# Check if there are identities to load.
#
# Return values:
#   0 = success, found a file.
#   1 = failed to match any files.
function ids_available() {
  for file in $ID_FILES; do
    [[ -f $file ]] && return 0
  done
  return 1
}

# Check if there are any identities already loaded
#
# Return values:
#   0 = success, there are ids loaded into the current agent.
#   1 = failed, there are none.
function ids_loaded() {
  [[ `ssh-add -L 2> /dev/null | grep "^ssh-" | wc -l` -eq 0 ]] && return 1 || return 0
}

# Go!
agent_setup

# Clean up scripts which should not be used after setup. Leave `start_sshagent`.
unset -f agent_setup
unset -f linksocket
unset -f linksocket_sudo
unset -f agent_available
unset -f ids_available
unset -f ids_loaded
