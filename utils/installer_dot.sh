#!/bin/bash

[[ -d $HOME/.cfg ]] && echo 'already exist, skipped' || git clone --bare git@gitlab.com:jpabbuehl/dotfiles.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
echo ".cfg" >> .gitignore
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config --local status.showUntrackedFiles no
exec "$@"
