# Code navigation tools

These tools are installed at session start by `scripts/session-setup.sh`. Use them to read and change code precisely, rather than searching by plain text.

- **ast (Python standard library):** read Python structure: functions, classes, imports, call sites. Use it before editing Python so changes match what is there.
- **tree-sitter** (Python bindings, with Python, Rust, TypeScript and Bash grammars): parse any supported file into a syntax tree. Use it when a question is about code structure in a language other than Python.
- **ast-grep** (`sg`): search code by its syntax, for example "every call to `f` with two arguments". Prefer it over grep when the pattern is about code structure.
- **networkx:** build and query graphs, such as import or call graphs, to answer "what depends on this?" before changing it.
- **Language servers:** `pyright` (Python), `vtsls` (TypeScript), `rust-analyzer` (Rust) give definitions, references and types. Use them to confirm a symbol's type or every place it is used.

Rules:
- Find code by structure first, then edit. Use grep only for plain text.
- Run the matching lint and type check after a change: `ruff`, `ty`, `tsc`, `cargo clippy`, `shellcheck`.
