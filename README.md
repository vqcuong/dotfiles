# Local configuration for awnsome shell-based apps and plugins

This is my personal configuration for NeoVim, Vim, Alacritty, Hyper and some other awesome tools to boost working productivity on shell environment

### Environment

- OS: <code>macOS sonoma</code>
- Model: <code>Macbook Air M2</code>
- Shell: <code>zsh</code>

### Tools and frameworks

- [Vim](https://www.vim.org/): <code>9.0</code>
- [NeoVim](https://neovim.io/): <code>0.9.4</code>
- [Alacritty](https://alacritty.org/): <code>0.12.3</code>
- [Hyper](https://hyper.is/): <code>3.4.1</code>
- [Tmux](https://github.com/tmux/tmux): <code>3.3a_a</code>
- [Ohmyzsh](https://ohmyz.sh/): <code>master (cb86d37)</code>
- [Ohmytmux](https://github.com/gpakosz/.tmux): <code>master (fd1bbb5)</code>
- [Exa](https://the.exa.website/): <code>v0.10.1</code>
- [thefuck](https://github.com/nvbn/thefuck): <code>3.32</code>

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
