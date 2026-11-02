# Environment: what each shared check does

These checks are boring on purpose. They are a safety net for people and coding agents, and they only report.

Each file in `workflows/` is one check, copied into a repo's `.github/workflows/`. Every check:

- runs on push to `main` and on manual start;
- only reports, never changes code;
- is cancelled by a newer run on the same branch (`concurrency` with `cancel-in-progress: true`), so rapid pushes never pile up or overlap.

| File | What it checks | Fails when | Needs |
| --- | --- | --- | --- |
| `lint-python.yml` | ruff lint, ruff format check, ty type check | Lint error, unformatted Python, or type error | Python files |
| `lint-rust.yml` | `cargo fmt --check`, `cargo clippy --all-targets -- -D warnings` | Unformatted Rust or any clippy warning | `Cargo.toml` |
| `lint-typescript.yml` | `tsc --noEmit` after `npm ci` | Type error, or lockfile missing or out of date | `package.json` and `package-lock.json` |
| `lint-shell-yaml.yml` | ShellCheck on every `*.sh` and on any file with a bash or sh shebang (such as `scripts/qdev`); yamllint on all YAML | Bash problem or YAML syntax or style problem | Shell scripts or YAML |
| `compose-validate.yml` | Every Compose file resolves (`docker compose config`) | A required variable is missing or a file is invalid | Compose files, plus any variables they require (set them in the env block first) |
| `gitleaks.yml` | Secrets in git history | A credential is found in any commit | Nothing; uses the built-in `GITHUB_TOKEN` |

## Rules

- A copied file does not update when this repo changes. Re-copy to pick up a fix.
- Pins: none. Each check uses the latest tool. Add a pin only when something forces one, and say why here.
- No secrets are stored in these files. The only token used is the built-in `GITHUB_TOKEN`.
- Fixes are made locally before pushing. These checks are a safety net, not an auto-fixer.

## Agent development components

These are separate from the reusable GitHub Actions checks above. `scripts/session-setup.sh` attempts to install them at Claude session start through `.claude/settings.json`. Both `AGENTS.md` and `CLAUDE.md` tell coding agents to use the available tools before editing and run appropriate checks afterward. Installation is best-effort: a failed install is logged, and the script continues. Availability must be verified in the actual environment.

| Component | Purpose | Provisioning |
| --- | --- | --- |
| Python `ast` | Inspect Python syntax structurally | Python standard library |
| ast-grep | Search code by syntax structure | Global npm install |
| Tree-sitter and Python, Rust, TypeScript, Bash grammars | Parse source into syntax trees for structural analysis | Python pip packages |
| NetworkX | Model and inspect dependency or relationship graphs | Python pip package |
| Pyright, vtsls, rust-analyzer | Navigate definitions, references, and types | pip, npm, and rustup respectively |
| Ruff, ty | Python lint, format, and type checks | Python pip packages |
| TypeScript compiler (`tsc`) | TypeScript type checking | Global npm install |
| Clippy, rustfmt | Rust lint and formatting checks | rustup components |
| ShellCheck, yamllint | Shell and YAML checks | apt and pip respectively |

Tree-sitter and NetworkX are **available capabilities, not steps required for every edit**: use syntax trees for structural code questions and graphs for dependency or relationship questions. The agent guidance is instructional; it does not prove the tools were installed successfully. The setup script uses unpinned package versions and depends on working Python/pip, npm, rustup, and apt environments with suitable permissions.
