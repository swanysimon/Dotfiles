function fish_prompt
    set -l last_command_status $status
    echo -n -s (cwd_fish_prompt) (set_color normal)
    echo (git_fish_prompt) (set_color normal)
    echo -n -s (status_fish_prompt $last_command_status) (set_color normal) " "
end


function cwd_fish_prompt
    printf "%s%s" (set_color yellow) (pwd)
end


function status_fish_prompt
    if [ $argv[1] -eq 0 ]
        printf "%s✓" (set_color green)
    else
        printf "%s(%s) ✗" (set_color red) $argv[1]
    end
end


function git_fish_prompt
    if not git rev-parse >/dev/null 2>&1
        return
    end

    echo -n -s " " (set_color magenta)

    git update-index -q --really-refresh >/dev/null 2>&1
    if not git rev-parse --verify HEAD >/dev/null 2>&1
        echo -s (set_color blue) "<initial git commit>" (set_color normal)
        return
    end

    set -l num_untracked_files (git ls-files --exclude-standard --others | wc -l | tr -d " ")
    if [ $num_untracked_files -gt 0 ]; or not git diff-index --quiet HEAD -- >/dev/null
        echo -n -s "◦"
    end

    set -l git_branch (
        git rebase --show-current-patch >/dev/null 2>&1;
            and echo "rebasing";
            or git branch --show-current
    )
    set -l git_upstream_branch (
        [ $git_branch = "rebasing" ];
            and git branch --list | grep "^*" | sed -e 's/.*(no branch, rebasing \(.*\))/\1/';
            or git rev-parse --abbrev-ref "@{upstream}" 2>/dev/null
    )

    set -l git_commit_count (git rev-list --count --left-right "HEAD...$git_upstream_branch" 2>/dev/null)
    set -l git_commits_ahead (echo $git_commit_count | cut -f 1)
    set -l git_commits_behind (echo $git_commit_count | cut -f 2)

    switch $git_commit_count
        case ""
            echo -s $git_branch "|<unknown upstream>"
        case "0"\t"0"
            echo -s $git_branch "|" $git_upstream_branch
        case "*"\t"0"
            echo -s $git_branch "↑" $git_commits_ahead "|" $git_upstream_branch
        case "0"\t"*"
            echo -s $git_branch "↓" $git_commits_behind "|" $git_upstream_branch
        case "*"
            echo -s $git_branch "↑" $git_commits_ahead "|" $git_commits_behind "↑" $git_upstream_branch
    end
end
