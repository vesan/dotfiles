# Dotfiles

## Installation

Install Homebrew:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"


### Dotfiles

Clone this repo into `~/.dotfiles`:

    git clone git@github.com:vesan/dotfiles.git ~/.dotfiles

And install:

    cd .dotfiles
    rake

### Apps

Run:

    brew bundle --file ~/.dotfiles/extras/Brewfile

`--no-upgrade` option is available.

### MacOS settings

Changes MacOS defaults.

Run:

    . ~/.dotfiles/extras/macos_defaults.sh

### Vim

Vim plugins are installed with [vim-plug](https://github.com/junegunn/vim-plug).

Installation:

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PlugInstall

### Development tooling

    . ~/.dotfiles/extras/development_tooling.sh

### Setting up new computer

- [ ] Setup Dash.app sync directory

