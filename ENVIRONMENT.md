# Environment: what each shared check does

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
