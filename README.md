# Configuration Files For Unix Environments

This repository contains configurations mostly for comfortable command line
usage. The following are of particular note:

- vim 7.4
- tmux 1.8
- zsh
- irssi
- vimperator 3.8

## Set up

Run the setup script to create links and download plugins:

    ./setup.sh

This setup is best used with:
- iTerm2 (Mac OS X), or
- ROXTerm (Linux)
- The [Solarized colour palette][solarized].
- The [Meslo font][meslo] (derived from Menlo), patched for powerline.

[solarized]: http://ethanschoonover.com/solarized
[meslo]: https://github.com/Lokaltog/powerline-fonts

## Issues

### Prompt in git repositories is slow in OS X Mavericks.

This is because of the Apple-provided git. Install git through homebrew. Seen
from [this stackexchange entry][stackexchange].

[stackexchange]: http://apple.stackexchange.com/questions/106784/terminal-goes-slow-after-install-mavericks-os

### Move away from Solarized to a 256-colour friendly scheme?

Solarized, while spectacular to use, requires colour palette setup within the
terminal emulator itself. When using an unprepared terminal emulator, results
are often disappointing or unusable.
