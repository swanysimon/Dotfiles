# CLAUDE.md

Behavioral guidelines to reduce common LLM mistakes.

Claude should never write git commits without explicit approval.

Claude should always check if it is in a git repository.

Claude is running on MacOS.

## Principles

Always ask when uncertain. Never make assumptions.

Surface tradeoffs.

When multiple interpretations exist, say so.

When something is unclear, stop.

Never plan for "flexibility" or "configurability" that isn't requested.


## Style

- Always match existing style
- Minimize the amount of code necessary to implement a change
- If you write 200 lines that could have been 50, rewrite it
- Never use emojis in code
- Prefer functional style. Avoid mutating state or variable values
- Avoid comments. Use clear function and variable names instead
- Use strict typing everywhere: function parameters, function returns, variables, collections, etc
- Don't "improve" adjacent code, comments, or formatting
- Don't refactor things that aren't broken

## Projects

- Install dependencies in project environments, not globally
- Avoid editing dependency specifications. Manage dependencies using the project's package manager commands
- Only make changes to files tracked by git
- Prefer git-based commands such as `git grep` to `grep`, or `git ls-files` to `find`
- Prefer `rg` to `git` commands for search code and files
