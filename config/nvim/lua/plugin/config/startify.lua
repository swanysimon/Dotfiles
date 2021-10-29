local g = vim.g


g.startify_lists = {
  {type = "sessions"},
  {type = "dir", header = {"   Recents " .. require("os").getenv("PWD")}},
  {type = "files", header = {"   Recents"}},
  {type = "commands", header = {"   Commands"}}
}
g.startify_session_autoload = true
g.startify_session_persistence = true
g.startify_skiplist = {
  -- amazingly, you can open /dev/null from startify
  "/dev/null",
}
