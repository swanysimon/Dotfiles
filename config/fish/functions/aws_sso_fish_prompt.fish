function aws_sso_fish_prompt
    # Only show if explicitly enabled (set usually in hostname-specific config)
    if not set -q SHOW_AWS_SSO_PROMPT
        return
    end

    set -f cache_dir ~/.aws/sso/cache
    if not test -d $cache_dir
        echo -ns " " (set_color red) "(⚠ sso:no-cache)" (set_color normal)
        return
    end

    # Find the most recent SSO cache file
    set -f cache_file (ls -t $cache_dir/*.json 2>/dev/null | head -n 1)
    if test -z "$cache_file"
        echo -ns " " (set_color red) "(⚠ sso:expired)" (set_color normal)
        return
    end

    # Extract expiration time from the cache file
    set -f expires_at (jq -r '.expiresAt' $cache_file 2>/dev/null)
    if test -z "$expires_at"; or test "$expires_at" = "null"
        echo -ns " " (set_color red) "⚠ sso:no-session" (set_color normal)
        return
    end

    # Convert ISO 8601 timestamp to epoch (handle UTC format)
    set -f expires_epoch (date -j -u -f "%Y-%m-%dT%H:%M:%SZ" $expires_at "+%s" 2>/dev/null)
    if test -z "$expires_epoch"
        # Try alternative format without Z
        set expires_epoch (date -j -u -f "%Y-%m-%dT%H:%M:%S" (string replace -r 'Z.*$' '' $expires_at) "+%s" 2>/dev/null)
    end

    if test -z "$expires_epoch"
        return
    end

    set -f now_epoch (date +%s)
    set -f diff (math $expires_epoch - $now_epoch)

    if test $diff -lt 0
        echo -ns " " (set_color red) "(⚠ sso:expired)" (set_color normal)
    else if test $diff -lt 60  # Less than 1 minute
        echo -ns " " (set_color red) "(⚠ sso:<1m)" (set_color normal)
    else if test $diff -lt 3600  # Less than 1 hour
        set -f minutes (math "round($diff / 60)")
        if test $minutes -lt 5
            echo -ns " " (set_color red) "(⚠ sso:"$minutes"m)" (set_color normal)
        else if test $minutes -lt 30
            echo -ns " " (set_color yellow) "sso:"$minutes"m" (set_color normal)
        else
            echo -ns " " (set_color green) "sso:"$minutes"m" (set_color normal)
        end
    else
        set -f hours (math "round($diff / 3600)")
        echo -ns " " (set_color green) "sso:"$hours"h" (set_color normal)
    end
end
