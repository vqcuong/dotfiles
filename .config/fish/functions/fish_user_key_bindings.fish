function fish_user_key_bindings
    bind --erase --preset \cl
    bind --erase --preset \cp
    bind \cx 'clear; commandline -f repaint'
end

fzf --fish | source
