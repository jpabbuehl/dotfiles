
# improve ls
hash gls >/dev/null 2>&1 || alias gls="ls"
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

alias ls='gls -AFh ${colorflag} --group-directories-first'
alias lsd='ls -l | grep "^d"' # only directories

alias grep='grep --color=auto --exclude-dir=\.git --exclude-dir=\.svn --exclude-dir=\.cache'

alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

alias config='/usr/bin/git --git-dir=/home/jp/dotfiles --work-tree=/home/jp'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias gs='git status'
alias mv='mv -i -v'
alias rm='rm -i -v'
alias ll='ls -alF'
alias cp='cp -v'
alias chmox='chmod -x'
alias la='ls -A'
alias l='ls -CF'
alias code='code-insiders'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


