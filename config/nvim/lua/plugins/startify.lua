local let = vim.g

let.startify_lists = {
  {type = "sessions"},
  {type = "dir", header = {"   Recents " .. require("os").getenv("PWD")}},
  {type = "files", header = {"   Recents"}},
}
let.startify_session_autoload = true
let.startify_session_persistence = true
let.startify_skiplist = {
  -- amazingly, I could open /dev/null from startify
  "/dev/null",
}
