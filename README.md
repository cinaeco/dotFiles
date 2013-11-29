# Configuration Files For *nix Environments

#### Software

Software configs that exist (versions are minimums for correct operation):
- vim 7.4
- emacs 24
- tmux 1.8
- zsh
- irssi & screen (for nicklist)
- nethack
- mongo
- Vimperator 3.8

Installs a user `ack` binary.

Best used with:
- iTerm2 (Mac OS X), or
- ROXTerm (Linux)
- The [Solarized colour palette][solarized].
- The [Meslo font][meslo] (derived from Menlo), patched for powerline.

[solarized]: http://ethanschoonover.com/solarized
[meslo]: https://github.com/Lokaltog/powerline-fonts

#### Issues

##### Prompt in git repositories is slow in OS X Mavericks.

This is because of the Apple-provided git. Install git through homebrew. Seen
from [this stackexchange entry][stackexchange].

[stackexchange]: http://apple.stackexchange.com/questions/106784/terminal-goes-slow-after-install-mavericks-os
