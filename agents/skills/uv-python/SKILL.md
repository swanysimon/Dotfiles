---
name: uv-python
description: Use when working with Python projects managed by uv (presence of uv.lock file) - prevents manual pyproject.toml edits, pip usage, and bypassing uv for running tools
---

# uv Python Project Management

## Overview

uv is an extremely fast Python package manager that manages dependencies, environments, and tool execution. When working in uv-managed projects, all dependency and execution operations must go through uv commands to maintain consistency between pyproject.toml, uv.lock, and the virtual environment.

## When to Use

**Detect uv-managed projects:**
- Presence of `uv.lock` file in project root
- `pyproject.toml` with `[tool.uv]` section or dependency groups

**Apply this skill for:**
- Adding/removing dependencies
- Installing dependencies
- Running tools (formatters, linters, type checkers, tests)

## Core Commands

| Task | Command | Example |
|------|---------|---------|
| Add dependency | `uv add <package>` | `uv add requests` |
| Add dev dependency | `uv add --dev <package>` | `uv add --dev pytest` |
| Remove dependency | `uv remove <package>` | `uv remove requests` |
| Install all dependencies | `uv sync` | `uv sync` |
| Install with dev deps | `uv sync --dev` | `uv sync --dev` |
| Run tool/script | `uv run <command>` | `uv run pytest` |
| Run Python script | `uv run python <script>` | `uv run python app.py` |

## Common Mistakes

| Mistake | Why It's Wrong | Correct Approach |
|---------|----------------|------------------|
| Manually editing `pyproject.toml` dependencies array | Doesn't update `uv.lock`, creates sync issues | Use `uv add` or `uv remove` |
| Using `pip install <package>` | Bypasses uv's lock file, installs outside uv's control | Use `uv add` for new deps, `uv sync` to install existing |
| Using `uv pip install` | Wrong uv subcommand for managed projects | Use `uv add` for managed projects |
| Running `python -m black` or `black` directly | May use wrong environment or version | Use `uv run black` |
| Running `pytest` directly | May not see project dependencies | Use `uv run pytest` |

## Rationalizations to Avoid

| Rationalization | Reality |
|-----------------|---------|
| "I know pyproject.toml format, I'll just add it" | Manual edits skip lock file updates and version resolution |
| "pip is faster for quick installs" | `uv add` is actually faster than pip and maintains consistency |
| "The tool is already installed, I can run it directly" | Direct execution may use wrong version or environment |
| "uv pip is still uv, so it's fine" | `uv pip` is for non-project use cases; managed projects use `uv add` |

## Running Linters and Formatters

For projects with development tools (ruff, black, mypy, etc.) as dependencies:

```bash
# Format code
uv run ruff format .
uv run black .

# Lint code
uv run ruff check --fix
uv run ruff check

# Type check
uv run mypy .
uv run ty check  # Alternative type checker
```

**Pattern:** Always prefix tool commands with `uv run` to ensure correct environment and version.

## Pre-Completion Checklist

Before completing any Python code change in a uv-managed project, run static analysis:

1. **Format code:** `uv run ruff format` (or `uv run black`)
2. **Fix linting issues:** `uv run ruff check --fix`
3. **Type check:** `uv run mypy .` (or `uv run ty check` if ty is used instead)

All checks must pass before considering work complete.

## When NOT to Use

- Projects without `uv.lock` (not uv-managed)
- Installing uv itself
- Global tool installations (`uv tool install` is different from project deps)
- Python version management (`uv python` commands)

## Real-World Impact

**Without this skill:**
- Dependency drift between pyproject.toml and lockfile
- "Works on my machine" issues from inconsistent environments
- Wasted time debugging version conflicts

**With this skill:**
- Consistent, reproducible environments
- Faster dependency operations than pip
- Single source of truth for all dependencies
