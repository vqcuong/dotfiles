function envsource
    for line in (cat $argv | grep -v '^#')
        if test -z "$line"
            continue
        end
        set item (string split -m 1 '=' $line)
        set -gx "$item[1]" "$item[2]"
    end
end
