# Keep ssh-agent persisting, even when in screen
# Have not solved the issue of being unable to connect to ssh-agent in ubuntu
# Have not had time to investigate oh-my-zsh's own ssh-agent plugin

#############
# SSH AGENT #
#############

# Don't do for OSX, as it has it's own handling of ssh-agent
if [ `uname` != Darwin ]; then

  # Check to see if SSH Agent is already running
  agent_pid="$(ps -ef | grep "ssh-agent" | grep -v "grep" | awk '{print($2)}')"

  # If the agent is not running (pid is zero length string)
  if [[ -z "$agent_pid" ]]; then
    # Start up SSH Agent

    # this seems to be the proper method as opposed to `exec ssh-agent bash`
    eval "$(ssh-agent)"

    # if you have a passphrase on your key file you may or may
    # not want to add it when logging in, so comment this out
    # if asking for the passphrase annoys you
    #ssh-add

  # If the agent is running (pid is non zero)
  else
    # Connect to the currently running ssh-agent

    # this doesn't work because for some reason the ppid is 1 both when
    # starting from ~/.profile and when executing as `ssh-agent bash`
    #agent_ppid="$(ps -ef | grep "ssh-agent" | grep -v "grep" | awk '{print($3)}')"
    agent_ppid="$(($agent_pid - 1))"

    # and the actual auth socket file name is simply numerically one less than
    # the actual process id, regardless of what `ps -ef` reports as the ppid
    agent_sock="$(find /tmp -path "*ssh*" -type s -iname "agent.$agent_ppid")"

    echo "Agent pid $agent_pid"
    export SSH_AGENT_PID="$agent_pid"

    echo "Agent sock $agent_sock"
    export SSH_AUTH_SOCK="$agent_sock"
  fi
fi

