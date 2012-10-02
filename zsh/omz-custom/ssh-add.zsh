# Add the first user identity if the local ssh-agent doesn't already have
# something.
#
# Silence error output for when we're sshing to a machine that we don't want to
# use ssh-agent forwarding for.
#
# This works well when there is only one identity. Don't know what
# would happen if a person had more than one private key to use.
if [[ `ssh-add -l 2> /dev/null` != *id_?sa* ]]; then
  ssh-add 2> /dev/null
fi
