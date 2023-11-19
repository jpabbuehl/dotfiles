#!/bin/bash

# Only run for interactive shells
case $- in
    *i*) ;;
    *) return;;
esac

# Environment Configuration
export OS_NAME=$(uname -s | tr '[:upper:]' '[:lower:]')  # Detect OS

# Checking if vim is available as an editor
if command -v vim &>/dev/null; then
    export EDITOR=vim    # Default text editor
    export VISUAL=vim    # Default visual editor
else
    export EDITOR=nano   # Fallback to nano if vim is not available
    export VISUAL=nano
fi

# Language and encoding settings
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8    
export LANGUAGE=en_US.UTF-8

# Shell Options
# Check and set each option with error handling
for option in histappend checkwinsize globstar nocaseglob cdspell cmdhist dirspell; do
    shopt -s "$option" 2>/dev/null || echo "Warning: Unable to set shell option $option"
done

# Command Completion Setup
# Function to source completion files if available
source_if_exists() {
    [ -f "$1" ] && . "$1"
}
source_if_exists /usr/share/bash-completion/bash_completion
source_if_exists /etc/bash_completion

# Set up lesspipe for non-text file viewing
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# SSH Config Autocomplete
# Autocomplete for known hosts in SSH config
if [[ -e "$HOME/.ssh/config" ]]; then
    complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh
fi

# Source External Configuration Files
# Loop through and source each file if it exists
for file in .bash_prompt .path .dot_bash .dot_git .dot_docker .dot_kubernetes .dot_python .dot_js .dot_others .key; do
    if [ -f "$HOME/$file" ]; then
        . "$HOME/$file"
    else
        echo "Warning: File $HOME/$file not found"
    fi
done

# History Management
# Ensure command history is preserved and shared across sessions
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# MacOS-specific Configurations
# Load additional bash completion if on MacOS
if command -v brew &>/dev/null; then
    source_if_exists "$(brew --prefix)/etc/bash_completion"
fi

# Powerline Configuration
# Set up Powerline if available
if command -v powerline-daemon &>/dev/null; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    source_if_exists "$HOME/.local/lib/python3.10/site-packages/powerline/bindings/bash/powerline.sh"
fi
