function fish_prompt
    set -f last_command_status $status

    # First line: current directory and vcs branch information
    echo -s (set_color yellow) (pwd) (set_color normal) (jj_fish_prompt) (git_fish_prompt)

    # Second line: result of previous command and prompt
    if [ $last_command_status -eq 0 ]
        echo -ns (set_color green) "✓"
    else
        echo -ns (set_color red) $last_command_status " ✗"
    end
    echo -ns (set_color normal) " "
end


function jj_fish_prompt
    # When not in a jj repository, don't output anything
    if not jj root &>/dev/null
        return
    end

    # Core: state indicator, short change ID, any local bookmarks
    set -f jj_out (jj log -r @ --no-graph --color=never -T '
        if(conflict, "⚠", if(empty, "○", "◦")) ++
        change_id.shortest() ++
        if(local_bookmarks,
            " " ++ separate("|", local_bookmarks),
            "")
    ' 2>/dev/null | string trim)

    test -z "$jj_out"; and return

    # Optional: ahead/behind counts for any tracked bookmarks on @.
    # Kept separate so a template error here doesn't suppress the core output.
    # Note: only reflects tracking status of the bookmark itself; if @ sits above
    # the bookmark (common in jj workflow), those extra changes are not counted.
    set -f jj_tracking (jj log -r @ --no-graph --color=never -T '
        separate("", local_bookmarks.map(|b|
            if(b.is_tracked(),
                if(b.tracking_ahead_count() > 0, "↑" ++ b.tracking_ahead_count(), "") ++
                if(b.tracking_behind_count() > 0, "↓" ++ b.tracking_behind_count(), ""),
                "")))
    ' 2>/dev/null | string trim)
    test -n "$jj_tracking"; and set jj_out "$jj_out$jj_tracking"

    echo -ns " " (set_color magenta) $jj_out (set_color normal)
end


function git_fish_prompt
    # When not in a git repository, don't change anything
    if not git rev-parse &>/dev/null
        return
    end

    # jj colocated repos leave git in detached HEAD; let jj_fish_prompt handle those
    if jj root &>/dev/null
        return
    end

    # The inital git commit state breaks many of the other git commands run; handle this early
    if not git rev-parse --verify HEAD &>/dev/null
        echo -ns " " (set_color blue) "<initial git commit>" (set_color normal)
        return
    end

    git update-index -q --really-refresh &>/dev/null

    echo -ns " " (set_color magenta)

    # Show repository dirty state
    if not git diff-index --quiet HEAD; or string length -q -- (git ls-files -om --exclude-standard)
        echo -ns "◦"
    end

    # Get display name for current branch
    set -f git_current_branch (
        if git rebase --show-current-patch &>/dev/null
            echo "rebasing"
        else
            set -l current_branch (git branch --show-current 2>/dev/null)
            if [ -z $current_branch ]
                echo detached
            else
                echo $current_branch
            end
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
