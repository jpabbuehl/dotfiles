#!/bin/bash

# improve ls
hash gls >/dev/null 2>&1 || alias gls="ls"
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

#alias ls='gls -AFh ${colorflag} --group-directories-first'
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'
alias config='/usr/bin/git --git-dir=/home/jp/dotfiles --work-tree=/home/jp'
alias grep='grep --color=auto'
alias ..='cd ..'
alias mv='mv -i -v'
alias rm='rm -i -v'
alias chmox='chmod -x'
alias code='code-insiders'
# General alias

# Git alias
alias gs='git status'

# Dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cs='config status'

# Kubernetes
# better bash autocompletion
# sudo snap alias microk8s.kubectl mk
# source <(mk completion bash | sed "s/kubectl/mk/g")
# k3s
alias k=kubectl
alias kn='kubectl config set-context --current --namespace'


complete -F __start_kubectl k

alias dcl='docker container ls'


alias g='git'

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &> /dev/null; then
    __git_complete g __git_main
fi;

alias pnpx="pnpm dlx"



# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_ed25519.pub | xclip -selection clipboard | echo '=> Public key copied to pasteboard.'"

# Pipe my private key to my clipboard.
alias prikey="more ~/.ssh/id_ed25519 | xclip -selection clipboard | echo '=> Private key copied to pasteboard.'"
