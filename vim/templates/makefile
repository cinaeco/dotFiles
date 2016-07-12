# Title

# Auto-Documenting Section. Displays a target list with `##` descriptions.
#
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# This will run as the default target i.e. `make` with no arguments.
# Unlike the blog post from which this is taken, there is no output colorisation
# (e.g. `\033[36m`) for better compatibility in different setups.
help:
	@grep -E '^[a-zA-Z_-]+:.*## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "* %-15s %s\n", $$1, $$2}'
.PHONY: help

example: dependency ## Run the example task

dependency: ## Run example's dependency

# Ultra-Small Makefile Tutorial. (Fuller tutorial: http://makefiletutorial.com)
# This is a valid makefile:
#
#     # Comments start with a `#`
#     # Put plain shell commands (/bin/sh) on each line.
#     target1:
#     	touch target1
#     	@echo "silenced lines are not printed, but command output is shown."
#     	# Argh, this comment line is printed!
#     	@# Note: First target = Default i.e. `make` = `make target1`
#
#     target2:
#     	@# Each line is its own shell instance. The `cd` below has no effect.
#     	cd ~/dotfiles
#     	touch target2
#     	@echo "** Multiple commands can be"; echo "** separated by semicolons"
#
#     target3: target4
#     	@# Oh, this target has a dependency!
#     	touch target3
#
#     target4:
#     	@# This will be called by target3, and will be run before target3 does.
#     	touch target4
#
#     # declare a variable string
#     all = target1 target2 target3 target4
#
#     # use a variable string (as list of dependencies)
#     everything: $(all)
#
#     clean:
#     	@# `clean` is not a special word. You have to build `make clean` yourself.
#     	rm $(all)
#
#     # Target names are actually expected files, so if a file with the target name
#     # exists, a target will not run:
#     #
#     #     $ touch clean
#     #     $ make clean
#     #     make: `clean` is up to date.
#     #
#     # Use `.PHONY` to not do a file check. Now `clean` will always run.
#     .PHONY: clean
#
