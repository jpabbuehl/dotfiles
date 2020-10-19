for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

bind Space:magic-space

export HISTTIMEFORMAT='%F %T '
export HISTCONTROL="ignoredups"       # no duplicate entries, but keep space-prefixed commands
export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history
type shopt &> /dev/null && shopt -s histappend  # append to history, don't overwrite it

export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

shopt -s cmdhist

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &> /dev/null; then
    __git_complete g __git_main
fi;

# Enable git branch name completion if file exists
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

shopt -s nocaseglob;
shopt -s cdspell;
shopt -s dirspell 2> /dev/null
shopt -s globstar 2> /dev/null
