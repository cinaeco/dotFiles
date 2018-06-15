# vim: set sw=2 ts=2 sts=2 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:
# dotfiles setup. Run `make install` to perform all setup tasks.

# Groups of targets
all = git bash zsh tmux ack vimperator tridactyl vim
rm-all = rm-git rm-bash rm-zsh rm-tmux rm-ack rm-vimperator rm-tridactyl rm-vim
aux = help install uninstall upgrade show-versions submodules xdg
.PHONY: $(all) $(rm-all) $(aux)

# Auto-Documenting Section. Displays a target list with `##` descriptions.
help:
	@grep -E '^[a-zA-Z_-]+:.*## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "* %-16s %s\n", $$1, $$2}'
	@echo ""
	@echo "Individual setup tasks:"
	@echo "$(all)"

install: $(all) ## Set up all configuration files.
	@echo "Install complete!"

uninstall: $(rm-all) ## Remove all configuration files.
	@echo "Uninstalled!"

upgrade: ## Update external files to latest versions.
	@./bin/dotfiles-upgrade

show-versions: ## List versions of installed software.
	@./bin/show-versions

# Setup Tasks {{{

submodules:
	@cd ~/dotfiles && git submodule sync && git submodule update --init

xdg:
	@mkdir -p $(XDG_CONFIG_HOME)

XDG_CONFIG_HOME ?= $(HOME)/.config

git:
	git config --global color.ui true
	git config --global core.editor vim
	git config --global core.excludesFile ~/dotfiles/git/globalignore
	git config --global diff.mnemonicPrefix true
rm-git:
	git config --global --unset color.ui true
	git config --global --unset core.editor vim
	git config --global --unset core.excludesFile ".*/dotfiles/git/globalignore"
	git config --global --unset diff.mnemonicPrefix true

bash:
	@./bin/linkup ~/dotfiles/shell/bash_profile ~/.bash_profile
	@./bin/linkup ~/dotfiles/shell/bashrc ~/.bashrc
rm-bash:
	rm ~/.bash_profile
	rm ~/.bashrc

zsh:
	@./bin/linkup ~/dotfiles/shell/env ~/.zshenv
	@./bin/linkup ~/dotfiles/shell/zshrc ~/.zshrc
rm-zsh:
	rm ~/.zshenv
	rm ~/.zshrc

tmux: submodules
	@./bin/linkup ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
rm-tmux:
	rm ~/.tmux.conf

ack:
	@./bin/linkup ~/dotfiles/ack/ackrc ~/.ackrc
rm-ack:
	rm ~/.ackrc

vimperator:
	@./bin/linkup ~/dotfiles/vimperator ~/.vimperator
	@./bin/linkup ~/dotfiles/vimperator/vimperatorrc ~/.vimperatorrc
rm-vimperator:
	rm ~/.vimperator
	rm ~/.vimperatorrc

tridactyl:
	@./bin/linkup ~/dotfiles/tridactyl/tridactylrc ~/.tridactylrc
rm-tridactyl:
	rm ~/.tridactylrc

vim: xdg
	@./bin/linkup ~/dotfiles/vim ~/.vim
	@./bin/linkup ~/dotfiles/vim/vimrc ~/.vimrc
	@./bin/linkup ~/dotfiles/vim $(XDG_CONFIG_HOME)/nvim
	@# Use barebones config to avoid vimrc errors on fresh dotfiles installs.
	@vim -N -u ~/dotfiles/vim/plugins.vim +PlugClean! +PlugUpdate! +quitall!
rm-vim:
	rm ~/.vim
	rm ~/.vimrc
	rm $(XDG_CONFIG_HOME)/nvim

# }}}
