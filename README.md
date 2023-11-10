# Local configuration for awnsome shell-based apps and plugins

This is my personal configuration for NeoVim, Vim, Alacritty, Hyper and some other awesome tools to boost working productivity on shell environment

## Environment

- OS: `macOS sonoma`
- Model: `Macbook Air M2`
- Shell: `zsh`

## Tools and frameworks
- [vim](https://www.vim.org/) (`9.0`) is a high-configurable lightweight terminal-based text editor
- [neovim](https://neovim.io/) (`0.9.4`) is a hyperextensible Vim-based text editor which have many adorable features and a growing supportive community
- [alacritty](https://alacritty.org/) (`0.12.3`) is a fast, cross-platform, OpenGL terminal emulator which has the outstanding speed and is optimized for working on macOS
- [hyper](https://hyper.is/) (`3.4.1`) is an Electron-based terminal which allows you to install and manage themes and plugins easily
- [kitty](https://sw.kovidgoyal.net/kitty/) is the fast, feature-rich and GPU based terminal emulator
- [tmux](https://github.com/tmux/tmux) (`3.3a_a`) is a terminal multiplexer letting you switch easily between several programs in one terminal, detach and reattach them to a different terminal
- [ohmyzsh](https://ohmyz.sh/) (master `cb86d37`)is a delightful, open source, community-driven framework for managing your Zsh configuration
- [ohmytmux](https://github.com/gpakosz/.tmux) (master `fd1bbb5`) is a self-contained, pretty and versatile .tmux.conf configuration file
- [starship](https://starship.rs/) (`1.16.0`) is the minimal, blazing-fast, and infinitely customizable prompt for any shell
- [ohmyposh](https://ohmyposh.dev/) (`18.19.0`) is a prompt theme engine for any shell

## Zsh themes
- [powerlevel10k](https://github.com/romkatv/powerlevel10k) is a theme for zsh which emphasizes speed, flexibility and out-of-the-box experience

## Zsh plugins
- [auto-ls](https://github.com/vqcuong/auto-ls) is a lightweight zsh plugin automatically doing ls after cd into a folder
- [exa-zsh-completion](https://github.com/vqcuong/exa-zsh-completion) is a zsh completion for [exa](https://the.exa.website/)
- [conda-zsh-completion](https://github.com/conda-incubator/conda-zsh-completion) is a zsh completion for [conda](https://docs.conda.io/en/latest/)
- [forgit](https://github.com/wfxr/forgit) is an effective zsh plugin for git
- [fzf-tab](https://github.com/Aloxaf/fzf-tab) is an alternative for zsh's default completion selection menu with fzf
- [oh-my-matrix](https://github.com/amstrad/oh-my-matrix) is no thing but a zsh plugin just for fun
- [ssh-connect](https://github.com/gko/ssh-connect) is a simple ssh manager
- [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) is a feature-rich syntax highlighting
- [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete) is a powerful autocompletion for zsh
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) is a fish-like fast and unobtrusive autosuggestions for zsh

## Powerful cli tools
- [fzf](https://github.com/junegunn/fzf) is a general-purpose command-line fuzzy finder
- [exa](https://the.exa.website/) (`0.10.1`) is a modern replacement for the venerable file-listing command-line program ls
- [thefuck](https://github.com/nvbn/thefuck) (`3.32`) is a magnificent app that corrects errors in previous console commands
- [trash-cli](https://github.com/andreafrancia/trash-cli) (`0.23.9.23`) is a command-line interface of Desktop Trash that avoids deleting files and folders accidentally
- [yq](https://github.com/mikefarah/yq) is a lightweight and portable command-line YAML, JSON and XML processor.
- [jq](https://github.com/jqlang/jq) is a lightweight and flexible command-line JSON processor akin to sed,awk,grep, and friends for JSON data
- [fd](https://github.com/sharkdp/fd) is a program to find entries in your filesystem
- [ripgrep](https://github.com/BurntSushi/ripgrep) is a line-oriented search tool that recursively searches the current directory for a regex pattern
- [httpie](https://httpie.io/) is a command-line HTTP client
- [conda](https://docs.conda.io/en/latest/) is an open source package management system and environment management system for Python 
- [pyenv](https://github.com/pyenv/pyenv/) is a tool letting you easily switch between multiple versions of Python
- [goenv](https://github.com/go-nv/goenv/) is a tool letting you easily switch between multiple versions of Golang 
- [k3s](https://k3s.io/) is a lightweight kubernetes distribution running on docker powered by [Rancher](https://www.rancher.com/)
- [k3d](https://github.com/k3d-io/k3d) is a tool for creating and manataining [k3s](https://k3s.io/) clusters.
- [pfetch](https://github.com/dylanaraps/pfetch) is a simple system information tool for sh

## Install and setup
- Follow the documentation from website for setting up all stuffs you like
- Install dotfiles

```
# install
git clone git@github.com:vqcuong/.my-dotenv.git $HOME/.config/.my-dotenv

# setup
ln -sf $HOME/.config/.my-dotenv/.hyper.js $HOME
ln -sf $HOME/.config/.my-dotenv/.vimrc $HOME
ln -sf $HOME/.config/.my-dotenv/.config/nvim $HOME/.config/
ln -sf $HOME/.config/.my-dotenv/.config/shell $HOME/.config/
ln -sf $HOME/.config/.my-dotenv/.config/alacritty $HOME/.config/
ln -sf $HOME/.config/.my-dotenv/.config/tmux/tmux.conf.local $HOME/.config/tmux/tmux.conf.local
ln -sf $HOME/.config/.my-dotenv/.config/zsh/.zshrc.omz ${ZDOTDIR:-$HOME}/.zshrc
```
