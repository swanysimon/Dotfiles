function jj-pushup
    set -l head (jj log -r @ --no-graph -T 'if(empty, "@-", if(description, "@", "@-"))' | string trim)
    set -l bookmark (jj log \
        -r "latest(bookmarks() & ::$head)" \
        --no-graph -T 'local_bookmarks.map(|b| b.name() ++ "\n")' \
        2>/dev/null | string trim | head -1)
    if test -z "$bookmark"
        echo "jj-pushup: no local bookmark found" >&2
        return 1
    end
    jj bookmark move $bookmark --to $head
    and jj git push --bookmark $bookmark
end
