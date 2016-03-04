# dotfiles

Configuration files for:

- Vim (7.4+) or NeoVim
- Vimperator (3.8+)
- Tmux (1.8+)
- Zsh (4.3.17+)
- Other bits and pieces

Heavy preference for `vim`-like bindings.

## Installation

Clone to a home folder.
Run `make install` or `./install`.
Restart the terminal session.

## Recommended

- Colour palette: [Solarized][].
- Font: [Meslo for Powerline][] (works well with [Rainbarf][]).
- NeoVim or Vim+Python/Ruby support - for [Vim-Plug][] parallel downloads.
- [The Silver Searcher][] - fast code search ([Ack][] included as fallback).
- [Pandoc][] - Vim creates documents from `.pandoc` files ([Pandoc Markdown][]).
- [pandoc-citeproc][] - bibliographical assistance when using Pandoc.

[Solarized]: http://ethanschoonover.com/solarized
[Meslo for Powerline]: https://github.com/Lokaltog/powerline-fonts
[Rainbarf]: https://github.com/creaktive/rainbarf
[Vim-Plug]: https://github.com/junegunn/vim-plug
[The Silver Searcher]: https://github.com/ggreer/the_silver_searcher
[Ack]: http://beyondgrep.com/
[Pandoc]: http://pandoc.org/
[Pandoc Markdown]: http://pandoc.org/README.html#pandocs-markdown
[pandoc-citeproc]: https://github.com/jgm/pandoc-citeproc

## Usage

Below is a non-exhaustive list of dotfiles usage.

### Zsh

- `z` folder jumping enabled, i.e. `z regex` = `cd /path/with/regex`.
- Shell prompt displays Git repository info and work tree status.
- Mostly-Mnemonic Git shortcuts, e.g. `gs` is `git status`, `gd` is `git diff`.
- SSH agent use is encouraged. `ssh-add` is run at shell start if an identity is
  not already loaded.
- A `.zshlocal` file can contain machine-specific settings.

### Vim

`Space` is the `<Leader>`.

- `<Leader>w` saves.
- `<Leader>q` closes files.
- `<Leader>l` lists loaded buffers and lets you jump to them by number.
- `<Leader>p` fuzzy-finds files.
- `<Leader>f` fuzzy-finds functions in the current file.
- `<Leader>t` opens a function/variable list for the current file.
- `<Leader>n` toggles line numbers.
- `<Leader>c` finds VCS conflict markers.
- Additional text objects exist (see `'Text Objects'` in [plugins.vim][]).
- Saving `.pandoc` files also outputs `.docx` versions.
- `:Goyo` for distraction-free writing.
- `:Dark`, `:Light` and `:Neon` colour schemes available.

[plugins.vim]: vim/plugins.vim

### Tmux

`<C-a>` = `Ctrl-a` = the tmux prefix.

- `<C-a> + [vi motion]` moves around panes.
- `<C-a> + <C-[vi motion]>` moves around windows.
- `Alt/Meta + number` moves to window number (1-10).
- `<C-a> + -` cuts a pane horizontally,
- `<C-a> + \` cuts a pane vertically (think `|`).
- `<C-a> + s` starts synchronized panes.
- `<C-a><C-s>` swaps between sessions.
- Mouse support works for selecting and resizing panes/windows.

### Vimperator

Apart from the default Vimperator goodness e.g.

- `/` searches like `vim`.
- `f` and `F` follow links on this tab/in a new tab.
- et cetera...

These dotfiles provide the following:

- `h` and `l` - move left and right between tabs.
- `j` and `k` - scroll the page down and up.
- `H`, `J`, `K`, `L` - scroll the page slowly (left, down, up, right).
- `<C-h>` and `<C-l>` - relocate a tab left and right.
