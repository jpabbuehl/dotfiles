# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
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

shopt -s cmdhist
shopt -s dirspell 2> /dev/null
shopt -s globstar 2> /dev/null

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

# Load other dotfiles
[ -n "$PS1" ] && source ~/.bash_profile

for file in ~/.{bash_prompt,bash_aliases,functions,path,dockerfunc,exports,extra}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
          echo "loading ${file}"
		source "$file"
	fi
done
unset file

