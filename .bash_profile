#!/bin/bash

echo 'bash_profile'

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

alias g='git'

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &> /dev/null; then
    __git_complete g __git_main
fi;

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[ -f /usr/local/share/bash-completion/bash_completion ] && . /usr/local/share/bash-completion/bash_completion
[ -f /usr/share/bash-completion/completions/git ] && . /usr/share/bash-completion/completions/git
# or source /etc/bash_completion.d/git

command -v timoni >/dev/null && . <(timoni completion bash)

# Enable git branch name completion if file exists
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
if [ -f $HOME/linuxbrew/.linuxbrew/bin/brew ]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

if [ -f $HOME/.cargo/env ]; then
  . "$HOME/.cargo/env"
fi

#!/bin/bash


# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


export PATH="$HOME/.poetry/bin:$PATH"
z