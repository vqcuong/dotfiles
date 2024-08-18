# Local configuration for awesome shell-based apps and plugins

This is my personal configuration for NeoVim, Vim, Alacritty, Hyper and some other awesome tools to boost working productivity on shell environment

## Environment

### Machine

- OS: `macOS sonoma`
- Model: `Macbook Air M2`
- Shell: `zsh`

### Editors

- [vim](https://www.vim.org/) is a high-configurable lightweight terminal-based text editor
- [neovim](https://neovim.io/) is a hyperextensible Vim-based text editor which have many adorable features and a growing supportive community

### Terminals

- [alacritty](https://alacritty.org/) is a fast, cross-platform, OpenGL terminal emulator which has the outstanding speed and is optimized for working on macOS
- [hyper](https://hyper.is/) is an Electron-based terminal which allows you to install and manage themes and plugins easily
- [kitty](https://sw.kovidgoyal.net/kitty/) is the fast, feature-rich and GPU based terminal emulator
- [tmux](https://github.com/tmux/tmux) is a terminal multiplexer letting you switch easily between several programs in one terminal, detach and reattach them to a different terminal

## Shell environment

### Shell languages

- [zsh](https://www.zsh.org/) is a shell designed for interactive use, although it is also a powerful scripting language
- [fish](https://fishshell.com/) is a smart and user-friendly command line shell for Linux, macOS, and the rest of the family

### Management frameworks

- [ohmyzsh](https://ohmyz.sh/) is a delightful, open source, community-driven framework for [zsh](https://www.zsh.org/)
- [zshell](https://wiki.zshell.dev/) is a Swiss Army Knife for [zsh](https://www.zsh.org/)
- [fisher](https://github.com/jorgebucaran/fisher.git) is a plugin manager for [fish](https://fishshell.com/)
- [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish.git) is a configurable plugin manager for [fish](https://fishshell.com/)

### Prompting frameworks

- [ohmytmux](https://github.com/gpakosz/.tmux) is a self-contained, pretty and versatile .tmux.conf configuration file
- [starship](https://starship.rs/) is the minimal, blazing-fast, and infinitely customizable prompt for any shell
- [ohmyposh](https://ohmyposh.dev/) is a prompt theme engine for any shell

### Zsh themes

- [powerlevel10k](https://github.com/romkatv/powerlevel10k) is a theme for zsh which emphasizes speed, flexibility and out-of-the-box experience

### Zsh plugins

- [auto-ls](https://github.com/vqcuong/auto-ls) is a lightweight zsh plugin automatically doing ls after cd into a folder
- [conda-zsh-completion](https://github.com/conda-incubator/conda-zsh-completion) is a zsh completion for [conda](https://docs.conda.io/en/latest/)
- [hacker-quotes](https://github.com/oldratlee/hacker-quotes.git) is an [ohmyzsh](https://ohmyz.sh/) plugin for displaying a hacker quote randomly when starting up
- [git-open](https://github.com/paulirish/git-open) is a tool for opening the repo website in browser
- [fzf-tab](https://github.com/Aloxaf/fzf-tab) is an alternative for zsh's default completion selection menu with fzf
- [oh-my-matrix](https://github.com/amstrad/oh-my-matrix) is no thing but a zsh plugin just for fun
- [ssh-connect](https://github.com/gko/ssh-connect) is a simple ssh manager
- [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) is a feature-rich syntax highlighting
- [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete) is a powerful autocompletion for zsh
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) is a fish-like fast and unobtrusive autosuggestions for zsh
- [zsh-ssh](https://github.com/sunlei/zsh-ssh) is a better host completion for ssh in zsh

## CLI tools

### Containerizations

- [dry](https://github.com/moncho/dry.git) is a terminal application to manage Docker and Docker Swarm
- [lazydocker](https://github.com/jesseduffield/lazydocker.git) is a simple terminal UI for both docker and docker-compose, written in Go
- [dive](https://github.com/wagoodman/dive.git) is a tool for exploring a docker image, layer contents, and discovering ways to shrink the size of your Docker/OCI image
- [ctop](https://github.com/bcicen/ctop.git) is a top-like interface for container metrics
- [docker-completion](https://formulae.brew.sh/formula/docker-completion) is a completion for docker
- [composerize](https://github.com/composerize/composerize.git) is a tool to convert docker command to docker-compose file
- [kompose](https://github.com/kubernetes/kompose.git) is a tool to convert docker-compose file to k8s manifests
- [kustomize](https://kustomize.io/) is a kubernetes native configuration management
- [k9s](https://github.com/derailed/k9s.git) is a tool for managing kubernetes cluster in style
- [k3s](https://k3s.io/) is a lightweight kubernetes distribution running on docker powered by [Rancher](https://www.rancher.com/)
- [k3d](https://github.com/k3d-io/k3d) is a tool for creating and manataining [k3s](https://k3s.io/) clusters

### Developer

- [howdoi](https://github.com/gleitz/howdoi.git) is a tool for instant coding answers via the command line
- [how2](https://github.com/santinic/how2.git) is a command-line for searching the simplest way to do something
- [httpie](https://httpie.io/) is a command-line HTTP client
- [conda](https://docs.conda.io/en/latest/) is an open source package management system and environment management system for Python
- [pyenv](https://github.com/pyenv/pyenv/) is a tool letting you easily switch between multiple versions of Python
- [goenv](https://github.com/go-nv/goenv/) is a tool letting you easily switch between multiple versions of Golang

### Git

- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy.git) is a tool to make git diffs more human-readable
- [delta](https://github.com/dandavison/delta.git) is a easier-to-read syntax-highlighting pager for git, diff
- [gitui](https://github.com/extrawurst/gitui.git) is a terminal-based interactive tool for git
- [lazygit](https://github.com/jesseduffield/lazygit) is a terminal based git client
- [forgit](https://github.com/wfxr/forgit) is an interactive git log viewer
- [tig](https://jonas.github.io/tig/) is a text-mode interface for Git

### Utilities

- [fzf](https://github.com/junegunn/fzf) is a general-purpose command-line fuzzy finder
- [exa](https://the.exa.website/) (`0.10.1`) is a modern replacement for the venerable file-listing command-line program ls
- [zoxide](https://github.com/ajeetdsouza/zoxide) is a smarter cd command, inspired by z and autojump
- [ripgrep](https://github.com/BurntSushi/ripgrep) is a line-oriented search tool that recursively searches the current directory for a regex pattern
- [thefuck](https://github.com/nvbn/thefuck) (`3.32`) is a magnificent app that corrects errors in previous console commands
- [trash-cli](https://github.com/andreafrancia/trash-cli) (`0.23.9.23`) is a command-line interface of Desktop Trash that avoids deleting files and folders accidentally
- [yq](https://github.com/mikefarah/yq) is a lightweight and portable command-line for processing yaml, json and xml
- [jq](https://github.com/jqlang/jq) is a lightweight and flexible command-line for processing json
- [fd](https://github.com/sharkdp/fd) is a program to find entries in your file system
- [bat](https://github.com/sharkdp/bat) is a cat(1) clone with syntax highlighting and Git integration
- [btop](https://github.com/aristocratos/btop.git) is a terminal-based system resource monitor
- [gtop](https://github.com/aksakalli/gtop.git) is a simple system monitoring dashboard on terminal
- [bottom](https://github.com/ClementTsang/bottom.git) is a customizable cross-platform graphical process/system monitor for the terminal
- [pfetch](https://github.com/dylanaraps/pfetch) is a simple system information tool for sh

### Fun

- [lolcat](https://github.com/busyloop/lolcat.git) is a tool for making your command output more colorful
- [fortune](https://formulae.brew.sh/formula/fortune) is a tool giving you best quotes in the world
- [cowsay](https://github.com/piuccio/cowsay) is a configurable talking cow

## Install and setup

- Follow the documentation from website for setting up all stuffs you like
- Install dotfiles

```
# install
git clone git@github.com:vqcuong/dotfiles.git $HOME/.config/dotfiles

# setup
ln -sf $HOME/.config/dotfiles/.hyper.js $HOME
ln -sf $HOME/.config/dotfiles/.vimrc $HOME
ln -sf $HOME/.config/dotfiles/.config/nvim $HOME/.config/
ln -sf $HOME/.config/dotfiles/.config/alacritty $HOME/.config/
ln -sf $HOME/.config/dotfiles/.config/tmux/tmux.conf.local $HOME/.config/tmux/tmux.conf.local
ln -sf $HOME/.config/dotfiles/.config/zsh/site-functions ${ZDOTDIR-$HOME}/.site-functions
ln -sf $HOME/.config/dotfiles/.config/zsh/.zshrc.omz ${ZDOTDIR-$HOME}/.zshrc
```
