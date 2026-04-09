---
name: opto-python
description: Best practices to use when working with Python repositories in the optoinvest github organization
---

# Opto Python

When a Python repository is managed by `uv`, use uv for all Python-related
commands.

Before completing any Python code change, run the following static code
analysis:
1. `uv run ruff format`
2. `uv run ruff check --fix`
3. `uv run mypy .`, or if mypy is not installed `uv run ty check`
