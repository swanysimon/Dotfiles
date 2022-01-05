local g = vim.g


g.startify_lists = {
  {type = "sessions", header = {"   Sessions"}},
  {type = "bookmarks", header = {"   Bookmarks"}},
  {type = "dir", header = {"   Recents in " .. require("os").getenv("PWD")}},
  {type = "files", header = {"   Recents"}},
}
g.startify_session_autoload = true
g.startify_session_persistence = true
g.startify_skiplist = {
  -- amazingly, you can open /dev/null from startify
  "/dev/null",
}
