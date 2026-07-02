function aws_sso_session_state
    # Outputs one of: disabled, no-cache, no-session, expired, or seconds-remaining (integer, may be negative)
    if not set -q SHOW_AWS_SSO_PROMPT
        echo disabled
        return
    end

    set -f cache_dir ~/.aws/sso/cache
    if not test -d $cache_dir
        echo no-cache
        return
    end

    # expiresAt is the 1-hour OAuth access token. After it expires, botocore attempts a refresh;
    # the statusline showing "expired" for a moment is fine — clopto login will auto-recover.
    set -f expires_at (jq -rs '[.[] | select(.accessToken != null) | .expiresAt] | sort | last // empty' $cache_dir/*.json 2>/dev/null)
    if test -z "$expires_at"; or test "$expires_at" = null
        echo no-session
        return
    end

    set -f expires_epoch (date -j -u -f "%Y-%m-%dT%H:%M:%SZ" $expires_at "+%s" 2>/dev/null)
    if test -z "$expires_epoch"
        set -f expires_epoch (date -j -u -f "%Y-%m-%dT%H:%M:%S" (string replace -r 'Z.*$' '' $expires_at) "+%s" 2>/dev/null)
    end

    if test -z "$expires_epoch"
        echo no-session
        return
    end

    math $expires_epoch - (date +%s)
end
