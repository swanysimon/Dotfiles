#!/usr/bin/env fish

set input (cat | string collect)

set model (printf '%s' $input | jq -r '.model.display_name')
set cwd (printf '%s' $input | jq -r '.workspace.current_dir')
set session_name (printf '%s' $input | jq -r '.session_name // empty')
set five_hour_reset (printf '%s' $input | jq -r '.rate_limits.five_hour.resets_at // empty')

set usage_info ""
if test -z "$five_hour_reset"
    set cost (printf '%s' $input | jq -r '.cost.total_cost_usd // empty')
    if test -n "$cost"
        set usage_info (printf 'Cost: $%.4f' $cost)
    end
else
    set used_pct (printf '%s' $input | jq -r '.rate_limits.five_hour.used_percentage // empty')
    if test -n "$used_pct"
        set remaining (math $five_hour_reset - (date +%s))
        if test $remaining -gt 0
            set total_mins (math -s0 "$remaining / 60")
            if test $total_mins -ge 60
                set time_str (printf '%dh %dm' (math -s0 "$total_mins / 60") (math -s0 "$total_mins % 60"))
            else
                set time_str $total_mins"m"
            end
            set usage_info (printf '%.0f%% used, %s remaining' $used_pct $time_str)
        else
            set usage_info (printf '%.0f%% used, window expired' $used_pct)
        end
    end
end

set aws_sso_info ""
set sso_state (aws_sso_session_state)
switch $sso_state
    case disabled no-session
        # nothing
    case no-cache expired
        set aws_sso_info "AWS SSO: expired"
    case '*'
        if test $sso_state -lt 0
            set aws_sso_info "AWS SSO: expired"
        else if test $sso_state -le 3600
            set mins (math -s0 "$sso_state / 60")
            if test $mins -lt 1
                set aws_sso_info "AWS SSO: <1m"
            else
                set aws_sso_info "AWS SSO: "$mins"m"
            end
        end
end

set parts
test -n "$session_name"; and set -a parts $session_name
set -a parts $model $cwd
test -n "$usage_info"; and set -a parts $usage_info
test -n "$aws_sso_info"; and set -a parts $aws_sso_info

printf '%s' $parts[1]
for part in $parts[2..]
    printf ' | %s' $part
end
echo
