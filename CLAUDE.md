# Code tools

Installed at session start by `scripts/session-setup.sh`. Use them before editing:
- **ast** (Python stdlib) and **ast-grep**: find code by structure, not plain text.
- **networkx** and **tree-sitter**: graphs and syntax trees for dependency or structure questions.
- **pyright**, **vtsls**, **rust-analyzer**: definitions, references, types.
- After a change, run the matching check: `ruff`, `ty`, `tsc`, `cargo clippy`, `shellcheck`.
