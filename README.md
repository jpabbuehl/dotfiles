# Dotfiles Management 🗂️

Manage and sync your dotfiles (configuration files) using a Git bare repository. This approach allows easy tracking of dotfiles and seamless application to any new system.

## Initial Setup 🛠️

Follow these steps to initialize your dotfiles repository:

1. **Initialize a Bare Git Repository**: 
```bash
git init --bare $HOME/.cfg
```

2. **Create an Alias for Dotfile Management**:
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

3. **Configure Git to Ignore Untracked Files**:
```bash
config config --local status.showUntrackedFiles no
```

4. **Persist the Alias in Your `.bashrc`**:
```bash
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

5. **Push Your Changes to a Remote Repository**:
```bash
git push
```

## Installing on a New System 🌟

Easily apply your dotfiles to a new system with these steps:

1. **Create the Configuration Alias**:
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

2. **Clone Your Dotfiles Repository**:
```bash
git clone --bare git@github.com:jpabbuehl/dotfiles.git $HOME/.cfg
```

3. **Prevent Git from Tracking Your Home Directory**:
```bash
echo ".cfg" >> .gitignore
```

4. **Backup Existing Dotfiles**:
To avoid conflicts, backup any existing dotfiles:
```bash
mkdir -p .config-backup &&
config checkout 2>&1 | egrep "\s+." | awk {'print $1'} |
xargs -I{} mv {} .config-backup/{}
```

5. **Checkout Your Dotfiles**:
```bash
config checkout
```

6. **Update Local Git Configuration**:
```bash
config config --local status.showUntrackedFiles no
```

## Notes 📝

- The `config` command can be used similarly to `git` for any dotfiles-related operations.
- Customize the `config` alias as per your preference.

Happy dotfile managing! 😄
