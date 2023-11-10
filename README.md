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
- [tmux](https://github.com/tmux/tmux) (`3.3a_a`) is a terminal multiplexer letting you switch easily between several programs in one terminal, detach and reattach them to a different terminal
- [ohmyzsh](https://ohmyz.sh/) (master `cb86d37`)is a delightful, open source, community-driven framework for managing your Zsh configuration
- [ohmytmux](https://github.com/gpakosz/.tmux) (master `fd1bbb5`) is a self-contained, pretty and versatile .tmux.conf configuration file
- [exa](https://the.exa.website/) (`0.10.1`) is a modern replacement for the venerable file-listing command-line program ls
- [thefuck](https://github.com/nvbn/thefuck) (`3.32`) is a magnificent app that corrects errors in previous console commands
- [trash-cli](https://github.com/andreafrancia/trash-cli) (`0.23.9.23`) is a command-line interface of Desktop Trash that avoids deleting files and folders accidentally
- [starship](https://starship.rs/) (`1.16.0`) is the minimal, blazing-fast, and infinitely customizable prompt for any shell
- [ohmyposh](https://ohmyposh.dev/) (`18.19.0`) is a prompt theme engine for any shell

## Zsh themes
- [powerlevel10k](https://github.com/romkatv/powerlevel10k) is a theme for zsh which emphasizes speed, flexibility and out-of-the-box experience

## Zsh plugins
- [auto-ls](https://github.com/vqcuong/auto-ls)
- [exa-zsh-completion](https://github.com/vqcuong/exa-zsh-completion)
- [conda-zsh-completion](https://github.com/conda-incubator/conda-zsh-completion)
- [forgit](https://github.com/wfxr/forgit)
- [fzf-tab](https://github.com/Aloxaf/fzf-tab)
- [oh-my-matrix](https://github.com/amstrad/oh-my-matrix)
- [ssh-connect](https://github.com/gko/ssh-connect)
- [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)
- [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

## Install and setup
- Follow the document from homesite to setup tools, frameworks, themes and plugins
## My customization

```
# install
git clone git@github.com:vqcuong/.my-dotenv.git $HOME/.config/.my-dotenv

# setup
ln -sf $HOME/.config/.my-dotenv/.config/shell $HOME/.config/
ln -sf $HOME/.config/.my-dotenv/.config/nvim $HOME/.config/
ln -sf $HOME/.config/.my-dotenv/.config/alacritty $HOME/.config/
ln -sf $HOME/.config/.my-dotenv/.config/tmux/tmux.conf.local $HOME/.config/tmux/tmux.conf.local
ln -sf $HOME/.config/.my-dotenv/.config/zsh/.zshrc.omz ${ZDOTDIR:-$HOME}/.zshrc
ln -sf $HOME/.config/.my-dotenv/.config/zsh/.aliases ${ZDOTDIR:-$HOME} 
ln -sf $HOME/.config/.my-dotenv/.vimrc $HOME
ln -sf $HOME/.config/.my-dotenv/.hyper.js $HOME
```
