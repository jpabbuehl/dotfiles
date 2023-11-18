#!/bin/bash

echo 'bash_aliases'


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
# alias kubectl='microk8s kubectl'
# better bash autocompletion
# sudo snap alias microk8s.kubectl mk
# source <(mk completion bash | sed "s/kubectl/mk/g")
alias awslocal='aws --endpoint-url http://localhost:4566 --profile test --region eu-central-1'
# k3s
export KUBECONFIG=~/.kube/config
alias k=kubectl
alias kn='kubectl config set-context --current --namespace'


export CR_PAT=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
complete -F __start_kubectl k

alias awslocal='aws --endpoint-url=http://localhost:4566'
alias t='todo.sh'
alias dcl='docker container ls'
alias yank='yank-cli'


export DOMAIN='homelab.com'
k_ns_clean () {
  kubectl get namespace $1 -o json \
  | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
  | kubectl replace --raw /api/v1/namespaces/$1/finalize -f -
}
