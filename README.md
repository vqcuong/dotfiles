# Local configuration for awnsome shell-based apps and plugins

This is my personal configuration for NeoVim, Vim, Alacritty, Hyper and some other awesome tools to boost working productivity on shell environment

### Environment

- OS: <code>macOS sonoma</code>
- Model: <code>Macbook Air M2</code>
- Shell: <code>zsh</code>

### Tools and frameworks

- [vim](https://www.vim.org/): <code>9.0</code>
- [neoVim](https://neovim.io/): <code>0.9.4</code>
- [alacritty](https://alacritty.org/): <code>0.12.3</code>
- [hyper](https://hyper.is/): <code>3.4.1</code>
- [tmux](https://github.com/tmux/tmux): <code>3.3a_a</code>
- [ohmyzsh](https://ohmyz.sh/): <code>master (cb86d37)</code>
- [ohmytmux](https://github.com/gpakosz/.tmux): <code>master (fd1bbb5)</code>
- [exa](https://the.exa.website/): <code>v0.10.1</code>
- [thefuck](https://github.com/nvbn/thefuck): <code>3.32</code>
- [trash-cli](https://github.com/andreafrancia/trash-cli): <code>0.23.9.23</code>

### Introduction
- [vim](https://www.vim.org/) is a high-configurable lightweight terminal-based text editor
- [neoVim](https://neovim.io/) is a hyperextensible Vim-based text editor which have many adorable features and a growing supportive community.
- [alacritty](https://alacritty.org/) is a fast, cross-platform, OpenGL terminal emulator which has the outstanding speed and is optimized for working on macOS
- [hyper](https://hyper.is/) is an Electron-based terminal which allows you to install and manage themes and plugins easily
- [tmux](https://github.com/tmux/tmux) is a terminal multiplexer letting you switch easily between several programs in one terminal, detach and reattach them to a different terminal.
- [ohmyzsh](https://ohmyz.sh/) is a delightful, open source, community-driven framework for managing your Zsh configuration
- [ohmytmux](https://github.com/gpakosz/.tmux) is a self-contained, pretty and versatile .tmux.conf configuration file
- [exa](https://the.exa.website/) is a modern replacement for the venerable file-listing command-line program ls
- [thefuck](https://github.com/nvbn/thefuck) is a magnificent app that corrects errors in previous console commands. 
- [trash-cli](https://github.com/andreafrancia/trash-cli) is a command-line interface of Desktop Trash that avoids deleting files and folders accidentally

### Install and setup

#### Vim

- Use default vim app on macOS

#### NeoVim

```
# can download directly from neovim.io
# or use homebrew:
brew install neovim
```

#### Alacritty

```
# can download directly from https://alacritty.org/
# or download file .dmg from https://github.com/alacritty/alacritty/releases page
# or install from homebrew:
brew install --cask alacritty
```

#### Hyper

```
# can download directly from https://hyper.is/
# or install from homebrew
brew update
brew install --cask hyper
```

#### Ohmyzsh

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# or follow the site: https://ohmyz.sh/#install or github page for more details
```

#### Ohmytmux

```
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -sf ~/.tmux/.tmux.conf ~/
# or follow the github page for more details
```

#### Exa

```
# can download directly from https://the.exa.website
# or install from homebrew
brew install exa
```

#### thefuck

```
# can install from homebrew
brew install thefuck
eval $(thefuck --alias)
```

#### trash-cli
```
brew install trash-cli
```

#### My customization

```
# install
git clone git@github.com:vqcuong/.my-dotenv.git ~/.my-dotenv

# link shortcut to home
ln -sf ~/.my-dotenv/.config/nvim ~/.config/
ln -sf ~/.my-dotenv/.config/alacritty ~/.config/
ln -sf ~/.my-dotenv/.vimrc ~/
ln -sf ~/.my-dotenv/.tmux.conf.local ~/
ln -sf ~/.my-dotenv/.zshrc.omz ~/.zshrc
ln -sf ~/.my-dotenv/.alias ~/
ln -sf ~/.tmux/.tmux.conf ~/
```
