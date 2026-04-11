#!/bin/bash

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
session_name=$(echo "$input" | jq -r '.session_name // empty')

used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_info=""
if [ -n "$used_pct" ]; then
    context_info=$(printf "Context: %.0f%%" "$used_pct")
fi

five_hour_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
sso_info=""
if [ -n "$five_hour_reset" ]; then
    now=$(date +%s)
    remaining=$((five_hour_reset - now))
    if [ $remaining -gt 0 ]; then
        total_mins=$((remaining / 60))
        if [ $total_mins -ge 60 ]; then
            hours=$((total_mins / 60))
            mins=$((total_mins % 60))
            sso_info="Claude SSO: ${hours}h ${mins}m remaining"
        else
            sso_info="Claude SSO: ${total_mins}m remaining"
        fi
    else
        sso_info="Claude SSO: expired"
    fi
fi

aws_sso_info=""
if [ -n "$SHOW_AWS_SSO_PROMPT" ]; then
    cache_dir="$HOME/.aws/sso/cache"
    if [ ! -d "$cache_dir" ]; then
        aws_sso_info="AWS SSO: no-cache"
    else
        cache_file=$(ls -t "$cache_dir"/*.json 2>/dev/null | head -n 1)
        if [ -z "$cache_file" ]; then
            aws_sso_info="AWS SSO: expired"
        else
            expires_at=$(jq -r '.expiresAt // empty' "$cache_file" 2>/dev/null)
            if [ -z "$expires_at" ] || [ "$expires_at" = "null" ]; then
                aws_sso_info="AWS SSO: no-session"
            else
                expires_epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%SZ" "$expires_at" "+%s" 2>/dev/null)
                if [ -z "$expires_epoch" ]; then
                    expires_epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%S" "${expires_at%Z*}" "+%s" 2>/dev/null)
                fi
                if [ -n "$expires_epoch" ]; then
                    now=$(date +%s)
                    diff=$((expires_epoch - now))
                    if [ $diff -gt 3600 ]; then
                        aws_sso_info=""
                    elif [ $diff -lt 0 ]; then
                        aws_sso_info="AWS SSO: expired"
                    else
                        mins=$((diff / 60))
                        if [ $mins -lt 1 ]; then
                            aws_sso_info="AWS SSO: <1m"
                        elif [ $mins -lt 60 ]; then
                            aws_sso_info="AWS SSO: ${mins}m"
                        fi
                    fi
                fi
            fi
        fi
    fi
fi

parts=()
[ -n "$session_name" ] && parts+=("$session_name")
parts+=("$model")
parts+=("$cwd")
[ -n "$context_info" ] && parts+=("$context_info")
[ -n "$sso_info" ] && parts+=("$sso_info")
[ -n "$aws_sso_info" ] && parts+=("$aws_sso_info")

result=""
for i in "${!parts[@]}"; do
    if [ $i -eq 0 ]; then
        result="${parts[$i]}"
    else
        result="$result | ${parts[$i]}"
    fi
done

echo "$result"
