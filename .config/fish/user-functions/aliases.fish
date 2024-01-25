set -gx FORGIT_NO_ALIASES true

alias c='clear'
alias f='fuck'
alias omp='oh-my-posh'

# ssh forward
function sfw --description "sfw <host> <server_port> [<local_port>]"
    set host $argv[1]
    set server_port $argv[2]
    set local_port $argv[3]
    if test -z "$local_port"
        set local_port $server_port
    end
    ssh -tL $local_port:localhost:$server_port $host
end

# exa
alias ls='exa --icons --color=always --group --time-style=long-iso'
alias l='ls -laH'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'

# docker-compose
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'

# git
# alias g="git"
# alias gap="git apply"
# alias gcfg="git config --list"
# alias gcl="git clone"
# alias gf="git fetch"
# alias gfo="git fetch origin"
# alias gm="git merge"
# alias grv="git revert"
# alias grsh="git reset HEAD"
# alias grshh="git reset HEAD --hard"
# alias gst="git status"
# alias gsm="git submodule"
# alias gsmu="git submodule update"
# alias gsmur="git submodule update --recursive"
# # git commit
# alias gc="git commit -v"
# alias gcm="git commit -m"
# alias gca="git commit -v -a"
# alias gcam="git commit -a -m"
# # git diff
# alias gdf="git diff"
# alias 'gdf.'="git diff ."
# # git pull and push
# alias gp="git push"
# alias gpo="git push origin"
# alias gpl="git pull"
# alias gplo="git pull origin"
# # git remote
# alias grt="git remote -vv"
# alias grtv="git remote -v"
# alias grta="git remote add"
# alias grtmv="git remote rename"
# alias grtrm="git remote remove"
# alias grts="git remote set-url"
# alias grtu="git remote update"
# # git tag
# alias gts="git tag -s"
# # git local
# # alias gad="git add"
# alias gaa="git add --all"
# alias gau="git add --update"
# alias gap="git add --patch"
# alias 'ga.'="git add ."
# alias grst="git restore"
# alias grss="git restore --source"
# alias grst="git restore --staged"
# # git worktree
# alias gwt="git worktree"

# alias copy='function _copy(){ pbcopy < $1; }; _copy $@'
alias copy='clipcopy'

# trash files or folders instead of pernamently remove them
alias rm='trash-put'

# vim and nvim command
alias v='vim'
alias nv='nvim'
alias n='nvim'
alias 'n.'='nvim .'

# lolcat wrapping
set lolcat_cmds brew cat curl docker docker-compose du fd head kubectl more man pip rg tail
set lolcat_args '$argv'
for cmd in $lolcat_cmds
    if command -v $cmd &>/dev/null
        set func "function $cmd; command $cmd $lolcat_args | lolcat; end"
        eval $func
    end
end
