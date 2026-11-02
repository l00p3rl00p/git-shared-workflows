# Environment: what each shared check does

Each file in `workflows/` is one check. Copy the ones you want into a repo's `.github/workflows/`. Every check:

- runs on push to `main` and on manual start;
- only reports, never changes code;
- is cancelled by a newer run on the same branch (`concurrency` with `cancel-in-progress: true`), so rapid pushes never pile up or overlap.

| File | What it checks | Fails when | Needs |
| --- | --- | --- | --- |
| `ruff.yml` | Python lint and format (`ruff check`, `ruff format --check`) | Lint error or unformatted Python | Python files in the repo |
| `shellcheck.yml` | Shell scripts (`shellcheck`) | Bash problem in any `*.sh` | Shell scripts; ShellCheck is preinstalled on the runner |
| `yaml-lint.yml` | YAML syntax and style (`yamllint`) | Malformed or badly styled YAML | Any YAML |
| `compose-validate.yml` | Every Compose file resolves (`docker compose config`) | A variable is missing or a file is invalid | Compose files, plus any variables they require (set them in the env block first) |
| `gitleaks.yml` | Secrets in git history (gitleaks) | A credential is found in any commit | Nothing; uses the built-in `GITHUB_TOKEN` |

## Rules

- A copied file does not update when this repo changes. Re-copy to pick up a fix.
- Pins: none. Each check uses the latest tool. Add a pin only when something forces one, and say why here.
- No secrets are stored in these files. The only token used is the built-in `GITHUB_TOKEN`.
