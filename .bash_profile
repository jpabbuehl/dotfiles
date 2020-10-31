#!/bin/bash

echo 'bash_profile'

# include .bashrc if it exists
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

alias g='git'

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &> /dev/null; then
    __git_complete g __git_main
fi;

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[ -f /usr/local/share/bash-completion/bash_completion ] && . /usr/local/share/bash-completion/bash_completion
[ -f /usr/share/bash-completion/completions/git ] && . /usr/share/bash-completion/completions/git
# or source /etc/bash_completion.d/git

# Enable git branch name completion if file exists
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

