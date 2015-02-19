# Add the first user identity if the local ssh-agent doesn't already have
# something.
#
# We silence error output for when we're sshing to a machine that we don't want
# to use ssh-agent forwarding for.
if [[ `ssh-add -L | grep "^ssh-" | wc -l` -eq 0 ]]; then
  ssh-add 2> /dev/null
fi

# Put ssh authentication socket in predicatable place for ssh-agent forwarding.
#
# This allows us to overcome stale sockets in tmux.
SOCK="/tmp/ssh-agent-$USER-tmux"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi
