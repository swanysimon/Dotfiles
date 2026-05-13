function aws_sso_fish_prompt
    set -f state (aws_sso_session_state)

    switch $state
        case disabled
            return
        case no-cache
            echo -ns " " (set_color red) "(⚠ sso:no-cache)" (set_color normal)
            return
        case no-session
            echo -ns " " (set_color red) "⚠ sso:no-session" (set_color normal)
            return
        case expired
            echo -ns " " (set_color red) "(⚠ sso:expired)" (set_color normal)
            return
    end

    set -f diff $state
    if test $diff -lt 0
        echo -ns " " (set_color red) "(⚠ sso:expired)" (set_color normal)
        return
    else if test $diff -gt 3600
        return
    end

    set -f minutes (math "round($diff / 60)")
    if test $minutes -lt 1
        echo -ns " " (set_color red) "(⚠ sso:<1m)" (set_color normal)
    else if test $minutes -lt 5
        echo -ns " " (set_color red) "(⚠ sso:"$minutes"m)" (set_color normal)
    else if test $minutes -lt 30
        echo -ns " " (set_color red) "sso:"$minutes"m" (set_color normal)
    else
        echo -ns " " (set_color green) "sso:"$minutes"m" (set_color normal)
    end
end
