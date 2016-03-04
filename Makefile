# vim: set sw=2 ts=2 sts=2 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:
# dotfiles setup. Run `make install` to perform all setup tasks.

# Groups of targets
all = git zsh tmux ack vimperator vim
rm-all = rm-git rm-zsh rm-tmux rm-ack rm-vimperator rm-vim

# Auto-Documenting Section. Displays a target list with `##` descriptions.
help:
	@echo "Available tasks:"
	@grep -E '^[a-zA-Z_-]+:.*## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "%-16s %s\n", $$1, $$2}'
	@echo ""
	@echo "Individual setup tasks:"
	@echo "$(all)"
.PHONY: help uninstall install $(all) $(rm-all)

install: prep $(all) ## Set up all configurations.
	@echo "Install complete!"

uninstall: $(rm-all) ## Remove all configurations.
	@echo "Uninstalled!"

show-versions: ## List versions of installed software.
	@./bin/show-versions

# Setup Tasks {{{

prep:
	@mkdir -p ~/.ssh $(XDG_CONFIG_HOME)
	@touch ~/.ssh/known_hosts

XDG_CONFIG_HOME ?= $(HOME)/.config

submodules:
	@cd ~/dotfiles && git submodule sync && git submodule update --init

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

zsh: submodules
	./bin/linkup ~/dotfiles/zsh/zshenv ~/.zshenv
	./bin/linkup ~/dotfiles/zsh/zshrc ~/.zshrc
rm-zsh:
	rm ~/.zshenv
	rm ~/.zshrc

tmux: submodules
	./bin/linkup ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
rm-tmux:
	rm ~/.tmux.conf

ack:
	./bin/linkup ~/dotfiles/ack/ackrc ~/.ackrc
rm-ack:
	rm ~/.ackrc

vimperator:
	./bin/linkup ~/dotfiles/vimperator ~/.vimperator
	./bin/linkup ~/dotfiles/vimperator/vimperatorrc ~/.vimperatorrc
rm-vimperator:
	rm ~/.vimperator
	rm ~/.vimperatorrc

vim:
	./bin/linkup ~/dotfiles/vim ~/.vim
	./bin/linkup ~/dotfiles/vim/vimrc ~/.vimrc
	./bin/linkup ~/dotfiles/vim $(XDG_CONFIG_HOME)/nvim
	./bin/linkup ~/dotfiles/vim/vimrc $(XDG_CONFIG_HOME)/nvim/init.vim
	@vim -u ~/dotfiles/vim/plugins.vim -N +PlugClean! +PlugUpdate! +quitall!
rm-vim:
	rm ~/.vim
	rm ~/.vimrc
	rm $(XDG_CONFIG_HOME)/nvim/init.vim
	rm $(XDG_CONFIG_HOME)/nvim

# }}}
