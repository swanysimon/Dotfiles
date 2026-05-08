#!/usr/bin/env bash

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
session_name=$(echo "$input" | jq -r '.session_name // empty')
usage_info=""
five_hour_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')

if [ -z "$five_hour_reset" ]; then
    cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
    [ -n "$cost" ] && usage_info=$(printf 'Cost: $%.4f' "$cost")
else
    used_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
    if [ -n "$used_pct" ]; then
        remaining=$((five_hour_reset - $(date +%s)))
        if [ $remaining -gt 0 ]; then
            total_mins=$((remaining / 60))
            if [ $total_mins -ge 60 ]; then
                time_str="$((total_mins / 60))h $((total_mins % 60))m"
            else
                time_str="${total_mins}m"
            fi
            usage_info=$(printf '%.0f%% used, %s remaining' "$used_pct" "$time_str")
        else
            usage_info=$(printf '%.0f%% used, window expired' "$used_pct")
        fi
    fi
fi

aws_sso_info=""
if [ -n "$SHOW_AWS_SSO_PROMPT" ]; then
    cache_file=$(ls -t "$HOME/.aws/sso/cache"/*.json 2>/dev/null | head -n 1)
    if [ -z "$cache_file" ]; then
        aws_sso_info="AWS SSO: expired"
    else
        expires_at=$(jq -r '.expiresAt // empty' "$cache_file" 2>/dev/null)
        if [ -n "$expires_at" ]; then
            expires_epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%SZ" "$expires_at" "+%s" 2>/dev/null)
            [ -z "$expires_epoch" ] && expires_epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%S" "${expires_at%Z*}" "+%s" 2>/dev/null)
            if [ -n "$expires_epoch" ]; then
                diff=$((expires_epoch - $(date +%s)))
                if [ $diff -lt 0 ]; then
                    aws_sso_info="AWS SSO: expired"
                elif [ $diff -le 3600 ]; then
                    mins=$((diff / 60))
                    [ $mins -lt 1 ] && aws_sso_info="AWS SSO: <1m" || aws_sso_info="AWS SSO: ${mins}m"
                fi
            fi
        fi
    fi
fi

parts=()
[ -n "$session_name" ] && parts+=("$session_name")
parts+=("$model" "$cwd")
[ -n "$usage_info" ] && parts+=("$usage_info")
[ -n "$aws_sso_info" ] && parts+=("$aws_sso_info")

printf '%s' "${parts[0]}"
printf ' | %s' "${parts[@]:1}"
echo
