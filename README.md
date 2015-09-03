# dotfiles

These are configuration files for:

- Vim (7.4+ or NEOVIM!!)
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
- [Vim-Plug][] needs plain `vim` to have Python or Ruby support to perform
  parallel downloads.
- [The Silver Searcher][] should be installed where possible. Otherwise, [Ack][]
  is part of this repo as a fallback (requires Perl 5.8.8).
- Install [Pandoc][] for vim to generate documents from `.pandoc` files ([Pandoc
  Markdown][]). Use [pandoc-citeproc][] for bibliographical assistance.

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

Here are some of the characteristics of how this config is used. The list is not
exhaustive: Reading the configs is the only way to really understand what is
going on. Dive in, learn, modify. Introspect constantly. See what others do.
Enjoy the amount of time wasted on tweaking a setup :D

### Zsh

 - Git prompt tries to reflect the actual file state, not just hint at change
   types.
 - Mostly-Mnemonic Git shortcuts. Go learn Git.
 - SSH agent forwarding persists through `tmux`/`sudo` when remotes also
   use these dotfiles. (Be a one-private-key kind of person.)
 - A `.zshlocal` file can contain machine-specific settings.
 - `z` folder jumping enabled, e.g. `z regex` = `cd /path/with/regex`.

### Vim

`Space` is the `<leader>`.

 - `<leader>d` is the filebrowser (netrw).
 - `<leader>p` fuzzy-finds files. Best in Git repositories.
 - `<leader>f` fuzzy-finds functions in the current file.
 - `<leader>t` opens a function/variable list for the current file.
 - `<leader>n` toggles line numbers.
 - `<leader>w` saves.
 - `<leader>q` closes files.
 - Additional text objects exist (see `'Text Objects'` in [plugins.vim][]).
 - Saving `.pandoc` files also outputs `.docx` versions.
 - Activate `:Goyo` for distraction-free writing.
 - Don't forget to invoke `:call UltraPower()`.

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

## Issues

### ZSH is slow in OS X Mavericks!

Check if the slowness occurs in Git repositories. If it does, this is because of
the Apple-provided version of Git. Install Git through homebrew.

More info: [stackexchange][]

[stackexchange]: http://apple.stackexchange.com/questions/106784/terminal-goes-slow-after-install-mavericks-os
