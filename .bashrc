#!/bin/bash

# Ensure script runs only in interactive mode
case $- in
    *i*) ;;
    *) return;;
esac

# OS Detection
export OS_NAME=""
case "$OSTYPE" in
  linux*)   OS_NAME='linux' ;;
  darwin*)  OS_NAME='macos' ;;
  win*)     OS_NAME='windows' ;;
  bsd*)     OS_NAME='bsd' ;;
  solaris*) OS_NAME='solaris' ;;
  *)        echo "unknown OS: $OSTYPE" ;;
esac

# Shell Options
shopt -s histappend      # Append to history file, don't overwrite
shopt -s checkwinsize    # Update LINES and COLUMNS
shopt -s globstar        # Match files and directories with '**'
shopt -s nocaseglob      # Case-insensitive globbing
shopt -s cdspell         # Autocorrect typos in path names
shopt -s cmdhist         # Save multi-line commands as single history entry
shopt -s dirspell 2> /dev/null # Attempt spelling correction on directory names

# Programmable Completion
if ! shopt -oq posix; then
  [ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
  [ -f /etc/bash_completion ] && . /etc/bash_completion
fi

# Set up less for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Configure chroot environment variable
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# SSH Config Autocomplete
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Source external files
[ -f "$HOME/.bash_prompt" ] && . "$HOME/.bash_prompt"
[ -f "$HOME/.path" ] && . "$HOME/.path"
[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"
[ -f "$HOME/.functions" ] && . "$HOME/.functions"
[ -f "$HOME/.dockerfunc" ] && . "$HOME/.dockerfunc"
[ -f "$HOME/.exports" ] && . "$HOME/.exports"
[ -f "$HOME/.extra" ] && . "$HOME/.extra"

# History Configuration
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# MacOS-specific configuration
if type brew &>/dev/null; then
  [ -f `brew --prefix`/etc/bash_completion ] && . `brew --prefix`/etc/bash_completion
fi

# Kubectl completion
source <(kubectl completion bash)

# Rust Environment
if [ -f $HOME/.cargo/env ]; then
  . "$HOME/.cargo/env"
fi

# Powerline Configuration
if type powerline-daemon &>/dev/null; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    [ -f /home/jp/.local/lib/python3.10/site-packages/powerline/bindings/bash/powerline.sh ] && source /home/jp/.local/lib/python3.10/site-packages/powerline/bindings/bash/powerline.sh
fi

# PNPM Configuration
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
alias pnpx="pnpm dlx"
