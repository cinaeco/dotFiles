# Expected location of the ssh-agent authentication socket
#
# `SSH_AUTH_SOCK` points to the socket through which users interact with
# ssh-agent loaded identities.
#
# Having this socket linked to a predictable place means a given user can expect
# loaded identities to persist
#  - in any shell instance
#  - in tmux, screen and similar multiplexers
#  - through `sudo su` to root (BUT NOT with '-' or plain `su`)
#
# This setup helps to persist ssh agent-forwarding across remotes.
[[ ! -z $SUDO_USER ]] && name=$SUDO_USER || name=$USER
SOCK="/tmp/ssh-agent-$name-tmux"

# Link up an existing socket to the expected location if it is not already.
linksocket() {
  if [[ ! -z $SSH_AUTH_SOCK && $SSH_AUTH_SOCK != $SOCK ]]; then
    ln -sf $SSH_AUTH_SOCK $SOCK &> /dev/null
  fi
  export SSH_AUTH_SOCK=$SOCK
}

# Find an ssh-agent at the expected location, or start a new one.
#
# `ssh-add` returning a code of 2 means this user has no usable ssh-agent.
#
# If a new agent is started, remember to link the new socket.
#
# Note: ssh-add return codes:
#   0 = success,
#   1 = specified command fails (e.g., no keys with ssh-add -l)
#   2 = unable to contact the authentication agent

# Try to reach an existing socket.
linksocket
ssh-add -l &> /dev/null
agent_reached=$?

# For `sudo su`: a user cannot access a socket with another user's symlink,
# so try to create a personal symlink to the same socket.
# TODO Find a cleaner, simpler way to decide to create symlinks.
if [[ $agent_reached -eq 2 ]]; then
  SOCK2="/tmp/ssh-agent-$USER-tmux"
  ln -sf `readlink $SOCK` $SOCK2
  export SSH_AUTH_SOCK=$SOCK2
  ssh-add -l &> /dev/null
  agent_reached=$?
fi

# Nothing worked. If there are any identities available, create a new agent.
#
# Defaults: ~/.ssh/id_rsa ~/.ssh/id_dsa ~/.ssh/id_ecdsa ~/.ssh/identity
identities_exist=false
default_files=(~/.ssh/id_rsa ~/.ssh/id_dsa ~/.ssh/id_ecdsa ~/.ssh/identity)
for file in $default_files; do
  [[ -f $file ]] && identities_exist=true && break
done

if [[ $identities_exist == true && $agent_reached -eq 2 ]]; then
  echo "Starting a new SSH Agent."
  eval `ssh-agent` &> /dev/null
  linksocket
fi

# Add any identities with the default file names if the agent does not have
# anything.
if [[ $identities_exist == true && `ssh-add -L | grep "^ssh-" | wc -l` -eq 0 ]]; then
  ssh-add
fi
