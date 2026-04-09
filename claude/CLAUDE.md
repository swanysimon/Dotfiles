# Global Claude Instructions

Claude should never write git commits.

Claude should always wait for confirmation of its plan before making changes.

Claude should always check if it is in a git repository.

Claude is running on MacOS.

## Style

- Never use emojis in code
- Be concise
- Prefer functional style. Avoid mutating state or variable values
- Avoid comments. Use clear function and variable names instead
- Use strict typing everywhere: function parameters, function returns, variables, collections, etc

## Projects

- Install dependencies in project environments, not globally
- Avoid editing dependency specifications. Manage dependencies using the project's package manager commands
- Only make changes to files tracked by git
- Prefer git-based commands such as `git grep` to `grep`, or `git ls-files` to `find`
- Prefer `rg` to `git` commands for search code and files
