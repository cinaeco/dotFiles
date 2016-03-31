# Start ssh-agent and load available identities. Standardize location of the
# ssh-agent authentication socket.
#
# `$SSH_AUTH_SOCK` is an environment variable set by `ssh-agent`, that points to
# a socket that allows users to connect to it. This script symlinks the socket
# to a predefined location (in a user's `.ssh` folder) so that a user's
# different shell instances (e.g. in screen or tmux) can be automatically
# connected to that same agent.

# Override `$KEY_FILES` before this script is loaded to specify which identities
# to load. Defaults to `ssh-add`'s standard files.
[[ ${#KEY_FILES[@]} = 0 ]] && KEY_FILES=(~/.ssh/id_rsa ~/.ssh/id_dsa ~/.ssh/id_ecdsa ~/.ssh/identity)

function agent_setup() {
  # Run if ssh is installed.
  command -v ssh >/dev/null || return

  # Make sure the folder for the symlink exists.
  mkdir -p ~/.ssh

  # Try to symlink an auth socket, to connect any existing agent.
  link_socket

  # Check for an agent:
  # 0 = agent running, has keys.
  # 1 = agent running, has no keys.
  # 2 = agent not running.
  ssh-add -l &>/dev/null
  case $? in
    1) has_key_files && add_keys ;;
    2) has_key_files && start_agent && add_keys ;;
  esac
}

# Create a symlink to an existing auth socket.
function link_socket() {
  local link="$HOME/.ssh/authsock"
  if [[ -n $SSH_AUTH_SOCK && $SSH_AUTH_SOCK != $link ]]; then
    ln -sf $SSH_AUTH_SOCK $link &>/dev/null
    export SSH_AUTH_SOCK=$link
  fi
}

# Check if there are keys to load on this machine.
# 0 = found a key file.
# 1 = did not find any key files.
function has_key_files() {
  for file in $KEY_FILES; do
    [[ -f $file ]] && return 0
  done
  return 1
}

# Add keys to an agent.
function add_keys() {
  ssh-add $KEY_FILES 2>/dev/null
}

# Start a new agent.
function start_agent() {
  echo "Starting a new SSH Agent."
  eval `ssh-agent` &>/dev/null
  link_socket
}

# Go!
agent_setup
