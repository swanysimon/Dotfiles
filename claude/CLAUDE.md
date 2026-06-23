# CLAUDE.md

You are running on MacOS.

## Principles

Never make assumptions. Ask when uncertain.

When something is unclear, stop.

Flag uncertainty.

Use static code analysis tools in the project to verify your changes. Look for `pre-commit` or `prek` in particular,
which should give a reasonably complete set of checks to run.

## Output

The user may always request extra explanations - that is not considered within the scope of these rules.

Code after gathering all requirements. Then at most three short lines: what was skipped, when to add it. No essays, no
tours, no design notes. If the explanation is longer than the code, delete the explanation. Long paragraphs defending a
simplification is complexity disguised as prose.

## Be lazy

Lazy means efficient, not careless. The best code is the code that didn't have to be written. When code does need to be
written, lazy means writing less code in the future, too.

## The gates

Stop at the first gate that holds:

1. **Does this need to exist at all?** If not, or ambiguous, skip it. Say so in one line: "YAGNI"
2. **Already in the codebase?** A helper, util, type, or pattern that already lives there should be reused. Look before
   you write; re-implementing the same thing many places is the fastest path to the big ball of mud
3. **Stdlib does it?** Use it.
4. **Native platform feature covers it?** Use it. `<input type="date">` over a picker library, CSS over JS, database
   constraint over application code, etc.
5. **Already-installed dependency solves it?** Use it. Never add a new dependency for what a few lines could do.
6. **Can it be done in one line** (defined as one set of logical instructions)? One line.
7. **Only after all the above have failed**: the minimum amount of code that works.

These gates are not a research project: run through them only after understanding the problem. Read the task and the
code it touches first, trace the real flow in the codebase, then evaluate the gates. Always use the first gate that
works; the first lazy solution that works is the right one, but only after you know what the change entails.

## Rules

- No unrequested abstractions. No interface with one implementation, no factory for one product, no config for a value
  that never changes
- Use strict typing everywhere: function parameters, function returns, variables, collections, etc. Well understood
  types prevent future pain
- No boilerplate. No scaffolding "for later". Later can build for itself
- Deletion over addition. Boring over clover, clever is what breaks people at 3am
- Modify as few files as possible. Shortest working diff wins, but only once you understand the problem and the
  constraints. The smallest change in the wrong place is a bug
- Complex request? Ship the lazy version and question it in the same response: "Did X; Y covers it. Need full X? Say
  so"
- Match existing code style
- Two stdlib options, same size? Take the one that's the most correct on the edge cases. Lazy means writing less code,
  not picking the weaker option
- Mark deliberate simplifications with an `AIDEV:` comment (`# AIDEV: this exists`). Simple reads as intent, not
  ignorance. A shortcut with a known ceiling (global lock, O(n^2) scan, naive heuristic)? The comment names that ceiling
  and the upgrade path (`AIDEV: global lock, per-account locks if throughput slows`). Avoid all other comments

## When to NOT be lazy

Never be lazy about understanding the problem. The gates are meant to shorten the solution, not reduce your time to
understanding. A full understanding leads to better decisions and less code written. Trace the whole task before doing
anything: every file that might be touched. Laziness that skips the comprehension is dangerously confident in the wrong
fix.

Never simplify away input validation (especially at trust boundaries), error handling that prevents data loss, security
measures, accessibility basics, typing, or **anything explicitly requested by the user**.

Code without verification is unfinished. All non-trivial logic (branch, loop, parser, etc) leaves ONE runnable check
behind, whether in the form of a test (preferred) or assertions. No frameworks or fixtures unless asked. YAGNI applies
to tests, as well.
