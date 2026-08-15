#!/usr/bin/env fish

function json_field --argument-names payload filter
    printf '%s' $payload | jq -r $filter
end

function format_token_count --argument-names count
    if test $count -ge 1000000
        printf '%gM' (math "round($count / 100000) / 10")
    else
        printf '%dk' (math "round($count / 1000)")
    end
end

function usage_colour --argument-names percent
    if test $percent -ge 80
        echo 31
    else if test $percent -ge 50
        echo 33
    else
        echo 32
    end
end

function format_duration --argument-names seconds
    awk -v s=$seconds 'BEGIN {
        if (s <= 0) { print "0m"; exit }
        d = int(s / 86400); h = int(s / 3600); m = int(s / 60)
        if (d) printf "%dd", d; else if (h) printf "%dh", h; else printf "%dm", (m ? m : 1)
    }'
end

function progress_bar --argument-names percent colour width
    set -l filled (math "floor($percent * $width / 100)")
    test $filled -gt $width; and set filled $width
    test $filled -lt 0; and set filled 0
    # collect -a preserves a zero-length run as an empty element; without it the
    # concatenation collapses to nothing and the bar disappears
    printf '\033[%dm%s%s\033[0m' $colour \
        (string repeat -n $filled ▓ | string collect -a) \
        (string repeat -n (math $width - $filled) ░ | string collect -a)
end

# .rate_limits is absent until the first API response, so payload contents cannot
# distinguish a subscription from a metered provider. The environment can.
function detect_provider
    if string match -qr '^(1|true)$' -- "$CLAUDE_CODE_USE_BEDROCK"
        echo bedrock
    else if string match -qi '*openrouter*' -- "$ANTHROPIC_BASE_URL"
        echo openrouter
    else
        echo subscription
    end
end

function openrouter_key
    if test -n "$ANTHROPIC_AUTH_TOKEN"
        printf '%s' $ANTHROPIC_AUTH_TOKEN
    else
        printf '%s' $ANTHROPIC_API_KEY
    end
end

# AIDEV: one state file per session accumulates in /tmp; macOS purges them
function openrouter_state_file --argument-names payload
    printf '/tmp/claude-openrouter-cost-%s' (json_field $payload '.session_id // empty')
end

function unpriced_generations --argument-names payload state_file
    set -l transcript (json_field $payload '.transcript_path // empty')
    test -r "$transcript"; or return
    # AIDEV: rescans the whole transcript per render; track a byte offset if sessions lag
    jq -R -r 'fromjson? | .message?.id? // empty
        | select(type == "string" and startswith("gen-"))' $transcript \
        | awk '!seen[$0]++' \
        | grep -vxF -f (cut -d' ' -f1 $state_file | psub)
end

function fetch_generation_costs --argument-names payload key
    set -l state_file (openrouter_state_file $payload)
    touch $state_file
    set -l pending (unpriced_generations $payload $state_file)
    set -l stale_marker ""

    # AIDEV: three fetches per render bounds latency, the marker covers the backlog
    if test (count $pending) -gt 3
        set stale_marker "~"
        set pending $pending[1..3]
    end

    for id in $pending
        set -l priced (curl -sf -m 2 -H "Authorization: Bearer $key" \
            "https://openrouter.ai/api/v1/generation?id=$id" \
            | jq -r '.data | select(.total_cost != null)
                     | "\(.total_cost) \(.cache_discount // 0) \(.provider_name // "?") \(.model // "?")"')
        if test -n "$priced"
            echo "$id $priced" >>$state_file
        else
            set stale_marker "~"
        end
    end
    printf '%s' $stale_marker
end

function accumulated_totals --argument-names payload
    set -l state_file (openrouter_state_file $payload)
    test -e $state_file; or return
    awk '{cost += $2; discount += $3; provider = $4; model = $5}
         END {printf "%.4f %.2f %s %s", cost, discount, provider, model}' $state_file
end

function openrouter_cost_segment --argument-names payload stale_marker
    set -l line (accumulated_totals $payload)
    set -l totals (string split ' ' -- "$line")
    test -n "$totals[1]"; or return
    set -l segment (printf 'Cost: %s$%s' "$stale_marker" $totals[1])
    test "$totals[2]" != 0.00; and set segment (printf '%s (cache -$%s)' $segment $totals[2])
    printf '%s\n' $segment
end

function openrouter_credits_segment --argument-names key
    set -l cache /tmp/claude-openrouter-credits
    if not find $cache -mmin -1 2>/dev/null | grep -q .
        set -l remaining (curl -sf -m 2 -H "Authorization: Bearer $key" \
            https://openrouter.ai/api/v1/key | jq -r '.data.limit_remaining // empty')
        test -n "$remaining"; and printf '%s\n' $remaining >$cache
        touch $cache
    end
    set -l capped (cat $cache 2>/dev/null | string trim)
    test -n "$capped"; or return
    printf '$%.2f left\n' $capped
end

function session_segment --argument-names payload
    json_field $payload '.session_name // empty'
end

function model_segment --argument-names payload provider
    if test "$provider" = openrouter
        set -l line (accumulated_totals $payload)
        set -l totals (string split ' ' -- "$line")
        if test -n "$totals[4]"
            printf '%s: %s\n' $totals[3] \
                (string replace -r '^[^/]+/' '' -- $totals[4] | string replace -r -- '-\d{8}$' '')
            return
        end
    end
    json_field $payload '.model.display_name'
end

function directory_segment --argument-names payload
    prompt_pwd (json_field $payload '.workspace.current_dir')
end

function context_segment --argument-names payload
    set -l line (json_field $payload '[.context_window.used_percentage,
        .context_window.total_input_tokens, .context_window.context_window_size]
        | map(. // "" | tostring) | @tsv')
    set -l fields (string split \t -- "$line")
    test -n "$fields[1]"; or return

    set -l percent (math "floor($fields[1])")
    set -l segment (printf '%s %d%%' (progress_bar $percent (usage_colour $percent) 6) $percent)
    test -n "$fields[2]" -a -n "$fields[3]"
    and set segment (printf '%s (%s/%s)' $segment \
        (format_token_count $fields[2]) (format_token_count $fields[3]))
    printf '%s\n' $segment
end

function usage_window_segment --argument-names window_length percent resets_at
    test -n "$percent"; or return
    set -l consumed (math "ceil($percent)")
    set -l segment (printf '%s %d%%' (progress_bar $consumed (usage_colour $consumed) 6) $consumed)
    test -n "$resets_at"
    and set segment (printf '%s (%s/%s)' $segment \
        (format_duration (math $resets_at - (date +%s))) $window_length)
    printf '%s\n' $segment
end

function rate_limit_segments --argument-names payload
    set -l line (json_field $payload '[.rate_limits.five_hour.used_percentage,
        .rate_limits.five_hour.resets_at, .rate_limits.seven_day.used_percentage,
        .rate_limits.seven_day.resets_at] | map(. // "" | tostring) | @tsv')
    set -l fields (string split \t -- "$line")
    usage_window_segment 5h "$fields[1]" "$fields[2]"
    usage_window_segment 7d "$fields[3]" "$fields[4]"
end

function session_cost_segment --argument-names payload
    set -l cost (json_field $payload '.cost.total_cost_usd // empty')
    test -n "$cost"; or return
    printf 'Cost: $%.4f\n' $cost
end

function openrouter_segments --argument-names payload stale_marker
    set -l key (openrouter_key)
    if test -z "$key"
        echo 'OpenRouter: no API key'
        return
    end
    openrouter_cost_segment $payload "$stale_marker"
    openrouter_credits_segment $key
end

function sync_provider_costs --argument-names payload provider
    test "$provider" = openrouter; or return
    set -l key (openrouter_key)
    test -n "$key"; or return
    fetch_generation_costs $payload $key
end

function meter_segments --argument-names payload provider stale_marker
    context_segment $payload
    switch $provider
        case bedrock
            session_cost_segment $payload
        case openrouter
            openrouter_segments $payload "$stale_marker"
        case '*'
            rate_limit_segments $payload
    end
end

function print_row
    test (count $argv) -eq 0; and return
    printf '%s' $argv[1]
    for segment in $argv[2..]
        printf ' | %s' $segment
    end
    echo
end

set payload (cat | string collect)
set provider (detect_provider)
set stale_marker (sync_provider_costs $payload $provider)

print_row (session_segment $payload) (model_segment $payload $provider) (directory_segment $payload)
print_row (meter_segments $payload $provider "$stale_marker")
