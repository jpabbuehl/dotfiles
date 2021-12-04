#!/bin/bash

echo 'bashrc'

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Detect os
export OS_NAME=""
case "$OSTYPE" in
  linux*)   OS_NAME='linux' ;;
  darwin*)  OS_NAME='macos' ;; 
  win*)     OS_NAME='windows' ;;
  bsd*)     OS_NAME='bsd' ;;
  solaris*) OS_NAME='solaris' ;;
  *)        echo "unknown OS: $OSTYPE" ;;
esac


# append to the history file, don't overwrite it
shopt -s histappend
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# match all files and zero or more directories and subdirectories.
shopt -s globstar
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
# Autocorrect typos in path names when using `cd`
shopt -s cdspell
# Bash save all lines of a multipe-line command in the same history entry
shopt -s cmdhist
#    If set, Bash attempts spelling correction on directory names 
#    during word completion if the directory name initially supplied does not exist.
shopt -s dirspell 2> /dev/null
#    If set, the pattern ‘**’ used in a filename expansion context will match a files
#    and zero or more directories and subdirectories. If the pattern is followed by a ‘/’, only directories and subdirectories match.
shopt -s globstar 2> /dev/null

# if $(type fzf > /dev/null); then
type shopt &> /dev/null && shopt -s histappend  # append to history, don't overwrite it

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Enable autocomplete in SSH config
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
	-o "nospace" \
	-W "$(grep "^Host" ~/.ssh/config | \
	grep -v "[?*]" | cut -d " " -f2 | \
	tr ' ' '\n')" scp sftp ssh

[ -f "$HOME/.bash_prompt" ] && . "$HOME/.bash_prompt"
[ -f "$HOME/.path" ] && . "$HOME/.path"
[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"
[ -f "$HOME/.functions" ] && . "$HOME/.functions"
[ -f "$HOME/.path" ] && . "$HOME/.path"
[ -f "$HOME/.dockerfunc" ] && . "$HOME/.dockerfunc"
[ -f "$HOME/.exports" ] && . "$HOME/.exports"
[ -f "$HOME/.extra" ] && . "$HOME/.extra"

export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


# Test if MacSO
which brew > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
  [ ! -f `brew --prefix`/etc/bash_completion ] || . `brew --prefix`/etc/bash_completion
fi


unset PROMPT_COMMAND 

