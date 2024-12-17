function fish_prompt
    set -f last_command_status $status

    # First line: current directory and git branch information
    echo -s (set_color yellow) (pwd) (set_color normal) (git_fish_prompt)

    # Second line: result of previous command and prompt
    if [ $last_command_status -eq 0 ]
        echo -ns (set_color green) "✓"
    else
        echo -ns (set_color red) $last_command_status " ✗"
    end
    echo -ns (set_color normal) " "
end


function git_fish_prompt
    # When not in a git repository, don't change anything
    if not git rev-parse >/dev/null 2>&1
        return
    end

    # The inital git commit state breaks many of the other git commands run; handle this early
    if not git rev-parse --verify HEAD >/dev/null 2>&1
        echo -ns " " (set_color blue) "<initial git commit>" (set_color normal)
        return
    end

    git update-index -q --really-refresh

    echo -ns " " (set_color magenta)

    # Show repository dirty state
    if not git diff-index --quiet HEAD; or string length -q -- (git ls-files -om --exclude-standard)
        echo -ns "◦"
    end

    # Get display name for current branch
    set -f git_current_branch (
        if git rebase --show-current-patch >/dev/null 2>&1
            echo "rebasing"
        else if [ -z (git branch --show-current) ]
            echo "detached"
        else
            git branch --show-current
        end
    )

    # Attempt to identify upstream branch
    set -f git_upstream_branch (
        if [ $git_current_branch = "rebasing" ]
            git branch --list | grep "^*" | sed -e 's:.*(no branch, rebasing \(.*\)):\1:'
        else if [ $git_current_branch = "detached" ]
            git branch --list | grep "^*" | sed -e 's:.*(HEAD detached from refs/heads/\(.*\)):\1:'
        else
            git rev-parse --abbrev-ref "@{upstream}" 2>/dev/null
        end
    )

    # Find deviation from upstream branch
    set -f git_commit_count (
        git rev-list --count --left-right --cherry-mark HEAD...$git_upstream_branch 2>/dev/null
    )

    # Special case: no tracking branch breaks next git commands; handle early
    if [ -z $git_commit_count ]
        echo -s $git_current_branch "|<unknown upstream>" (set_color normal)
        return
    end

    set -f git_display_branch (
        echo -n $git_current_branch
        set -l git_commits_ahead (echo $git_commit_count | cut -f 1)
        [ $git_commits_ahead -gt 0 ]; and echo "↑"$git_commits_ahead
    )
    if [ $git_current_branch != "rebasing" ]; and [ $git_current_branch != "detached" ]
        set -l git_remote_name (git config branch.$git_current_branch.remote)
        if [ $git_upstream_branch = $git_remote_name"/"$git_current_branch ]
            set -f git_is_tracking_same_named_branch true
            set git_display_branch $git_display_branch"{"$git_remote_name"}"
        end
    end

    set -f git_display_upstream (
        not set -q git_is_tracking_same_named_branch; and echo -ns "|" $git_upstream_branch
        set -l git_commits_behind (echo $git_commit_count | cut -f 2)
        [ $git_commits_behind -gt 0 ]; and echo -s "↓" $git_commits_behind
    )

    echo -s $git_display_branch $git_display_upstream (set_color normal)
end
