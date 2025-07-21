# Arch Linux documentation

Documentation for my Arch linux system based on Omarchy.

## Dotfiles

Dotfiles are managed in a git repository at `~/.dotfiles` that uses `$HOME` as the git worktree. Interacting with the dotfiles repo requires the use of the `dotfiles` alias rather than git directly.

This system is based on the description at https://www.atlassian.com/git/tutorials/dotfiles and is summarized below. 

### Setup / initial installation

Add the following shell alias to interact with the dotfiles repo:

```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Create a bare git repo at `.dotfiles.`

```
git init --bare $HOME/.dotfiles
```

Don't show untracked files in the repo.

```
dotfiles config --local status.showUntrackedFiles no
```

### Install dotfiles onto a new system

Add the shell alias for interacting with the dotfiles repo.

```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Clone the repo into `~/.dotfiles`.

```
git clone --bare <git-repo-url> $HOME/.dotfiles
```

Check out the dotfiles.

```
dotfiles checkout master
```

Don't show untracked files in the repo.

```
dotfiles config --local status.showUntrackedFiles no
```
