function lolfish -d "such rainbow. wow"
    set -l colors ff0000 ff5700 ff8700 ffaf00 ffd700 \
        ffff00 d7ff00 afff00 87ff00 57ff00 \
        00ff00 00ff57 00ff87 00ffaf 00ffd7 \
        00ffff 00d7ff 00afff 0087ff 0057ff \
        0000ff 5700ff 8700ff af00ff d700ff \
        ff00ff ff00d7 ff00af ff0087 ff0057

    if test -z $lolfish_next_color; or test $lolfish_next_color -gt (count $colors); or test $lolfish_next_color -le 0
        set -g lolfish_next_color 1
    end

    set -l color_step 1

    for arg in $argv

        switch $arg
            case ' ' \( \) \[ \] \: \@ \{ \} \/
                set_color normal
                echo -n -s $arg
                continue
        end

        if test -z $color
            set color $lolfish_next_color
        else if test $color -gt (count $colors); or test $color -le 0
            set color 1
        end

        set_color $colors[$color]
        echo -n -s $arg
        set color (math $color + $color_step)
    end

    set lolfish_next_color (math $lolfish_next_color + $color_step)
    set_color normal
end

function _git_branch_name
    echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l normal (set_color normal)

    set -l arrow λ
    set -l cwd $blue(basename (prompt_pwd))

    if [ (_git_branch_name) ]
        set git_info $green(_git_branch_name)
        set git_info ":$git_info"

        if [ (_is_git_dirty) ]
            set -l dirty "*"
            set git_info "$git_info$dirty"
        end
    end

    lolfish $cwd $git_info $normal ' ' $arrow ' '
end

function fish_right_prompt
end
