# dotfiles

These are configuration files for:

- Vim 7.4+ or NeoVim
- Vimperator (3.8+)
- Tmux
- Zsh
- Other bits and pieces

The configs reflect a heavy preference for `vim`-like bindings.

## Requirements

- The configs only make sense with at least `zsh` and `vim` installed.
- `zsh` has been used with 4.3.17 and up.
- `vim` can work with 7.3, but is best with 7.4+ to have all the right patches.

## Optional

- The [Solarized][] dark colour palette makes the `zsh` prompt nicer.
- The [Meslo][] font (Menlo, patched for powerline), makes `vim` and `tmux` look
  better, and has [Rainbarf][] graph glyphs.
- Vim with Python/Ruby support or NeoVim is needed for [Vim-Plug][] to perform
  parallel downloads.
- [The Silver Searcher][] should be installed where possible. If not available,
  [Ack][] (part of this repo) will be used as a fallback (requires Perl 5.8.8).
- Install [Pandoc][] for vim to generate documents from `.pandoc` files ([Pandoc
  Markdown][]). Install [pandoc-citeproc][] for bibliographical assistance.

[Solarized]: http://ethanschoonover.com/solarized
[Meslo]: https://github.com/Lokaltog/powerline-fonts
[Rainbarf]: https://github.com/creaktive/rainbarf
[Vim-Plug]: https://github.com/junegunn/vim-plug
[The Silver Searcher]: https://github.com/ggreer/the_silver_searcher
[Ack]: http://beyondgrep.com/
[Pandoc]: http://pandoc.org/
[Pandoc Markdown]: http://pandoc.org/README.html#pandocs-markdown
[pandoc-citeproc]: https://github.com/jgm/pandoc-citeproc

## Set Up

Clone this repository to the home folder, and run `setup.sh`:

    $ ~/dotfiles/setup.sh

Restart the shell after that.

## Useful Things

Below are some examples of how this config is used. The list is not exhaustive.
Users are encouraged to actually read the dotfiles. Comments within the configs
hopefully help users to understand, modify and improve.

And improve you should. Streamline your work flow. Introspect constantly. See
what others do. Enjoy the amount of time wasted on tweaking a setup :D

### Zsh

- Git prompt status tries to reflect the actual work tree state, not just hint
  at existence of change types like others.
- Mostly-Mnemonic Git shortcuts. (Go learn Git.)
- SSH agent forwarding persists through `tmux`/`sudo` when remotes also
  use these dotfiles. (Please use agent forwarding with prudence.)
- A `.zshlocal` file can contain machine-specific settings.
- `z` folder jumping enabled, e.g. `z regex` = `cd /path/with/regex`.

### Vim

`Space` is the `<Leader>`.

- `<Leader>w` saves.
- `<Leader>q` closes files.
- `<Leader>l` lists loaded buffers and lets you jump to them by number.
- `<Leader>p` fuzzy-finds files. Best in Git repositories.
- `<Leader>f` fuzzy-finds functions in the current file.
- `<Leader>t` opens a function/variable list for the current file.
- `<Leader>n` toggles line numbers.
- Additional text objects exist (see `'Text Objects'` in [plugins.vim][]).
- Saving `.pandoc` files also outputs `.docx` versions.
- `:Goyo` for distraction-free writing.
- `:Dark`, `:Light` and `:Neon` colour schemes available.

[plugins.vim]: vim/plugins.vim

### Tmux

`Ctrl-a` is the `Prefix`. `PrefixHold` = Hold down `Ctrl` during that binding.

- `Prefix + vi motion` moves around panes.
- `PrefixHold + vi motion` moves around windows.
- `Alt/Meta + number` moves to window number (1-10).
- `Prefix + -` cuts a pane horizontally,
- `Prefix + \` cuts a pane vertically (think `|`).
- `Prefix + s` starts synchronized panes.
- `PrefixHold + s` swaps between sessions.
- Mouse support works to select/resize panes/windows.

### Vimperator

Apart from all the default vimperator goodness e.g.
- `/` searches like `vim`.
- `f` and `F` follow links on this tab/in a new tab.
- et cetera...

This config provides the following:
- `h` and `l` move left and right between tabs.
- `j` and `k` half-pages down and up (`<C-d>`/`<C-u>` equivalents).
- `H`, `J`, `K`, `L` are small motions (5 lines or chars) within a page.
- `<C-h>` and `<C-l>` relocate a tab left and right.
