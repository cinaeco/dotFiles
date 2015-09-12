# Load machine-specific settings
#
# Some settings are specific to machines and should not be in a general dotfiles
# repository. Read a local file that stores such settings.
if [[ -r ~/.zshlocal ]]; then
  source ~/.zshlocal
fi
