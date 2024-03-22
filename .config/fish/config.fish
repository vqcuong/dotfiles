if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_user_paths /usr/local/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths
set -U fish_user_paths $HOME/.apps/poetry/bin $fish_user_paths
set -gx XDG_CONFIG_HOME $HOME/.config

if test -f $HOME/.config/fish/config.local.fish
    source $HOME/.config/fish/config.local.fish
end
if test -d $HOME/.config/fish/.local
    for f in $HOME/.config/fish/.local/*
        if test -f $f
            source $f
        end
    end
end
if test -d $HOME/.config/fish/user-functions
    for f in $HOME/.config/fish/user-functions/*
        if test -f $f
            source $f
        end
    end
end

# set -U fish_user_paths /opt/homebrew/bin/ $fish_user_paths
/opt/homebrew/bin/brew shellenv | source

# add fish completions from homebrew
if test -d (brew --prefix)"/share/fish/completions"
    set -p fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

# user configuration
thefuck --alias | source
zoxide init fish | source
orbctl completion fish | source

# setup conda
function _eval_conda
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    set conda_prefix $argv[1]
    if test -f $conda_prefix/bin/conda
        eval $conda_prefix/bin/conda "shell.fish" hook | source
    end
    # <<< conda initialize <<<
end

function _setup_conda
    set conda_prefix $argv[1]
    if test -z $conda_prefix
        set conda_prefix $HOME/.apps/mambaforge
    end
    if test -d $conda_prefix
        _eval_conda $conda_prefix
    end
    if ! command -v conda &>/dev/null
        rm -rf $conda_prefix
        set os_name $(uname -s)
        set os_arch $(uname -m)
        set tag_name $(http https://api.github.com/repos/conda-forge/miniforge/releases/latest | jq -r '.tag_name')
        http -d https://github.com/conda-forge/miniforge/releases/download/$tag_name/Mambaforge-$os_name-$os_arch.sh -o /tmp/mambaforge.sh
        bash /tmp/mambaforge.sh -b -p $conda_prefix
        _eval_conda $conda_prefix
    end
end

if test "$TERM_PROGRAM" = alacritty
    _setup_conda
end

# setup pyenv
function _setup_pyenv
    set -g -x PYENV_ROOT $HOME/.apps/pyenv
    fish_add_path -g -a $PYENV_ROOT/bin
    if ! command -v pyenv &>/dev/null
        mkdir -p $(dirname $PYENV_ROOT)
        curl https://pyenv.run | bash
        # git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
    end
end

if test "$TERM_PROGRAM" = alacritty
    _setup_pyenv
end
# setup goenv
function _setup_goenv
    set -g -x GOENV_ROOT $HOME/.apps/goenv
    set -g -x GOENV_GOPATH_PREFIX $HOME/.apps/go
    set -g -x GOENV_GOMOD_VERSION_ENABLE 1
    fish_add_path -g -a $GOENV_ROOT/bin
    if ! command -v goenv &>/dev/null
        mkdir -p $(dirname $GOENV_ROOT)
        git clone https://github.com/go-nv/goenv.git $GOENV_ROOT
    end
    goenv init - | source
    fish_add_path -g -a $GOENV_ROOT/shims
end
if test "$TERM_PROGRAM" = alacritty
    _setup_goenv
end

if test "$TERM_PROGRAM" != WarpTerminal
    starship init fish | source
else
    set POSH_THEMES_PATH $(brew --prefix oh-my-posh)/themes
    set OMP_THEME catppuccin
    oh-my-posh completion fish | source
    oh-my-posh init fish --config $POSH_THEMES_PATH/$OMP_THEME.omp.json | source
end
