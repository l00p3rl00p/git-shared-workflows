# git-shared-workflows

Boring engineering checks as GitHub Actions workflows. Copy the files you want into a repo's `.github/workflows/` folder. Nothing here runs by itself, and nothing here changes code.

| File | Checks | Needs in the repo |
| --- | --- | --- |
| `workflows/lint-python.yml` | ruff lint and format, ty type check | Python files |
| `workflows/lint-rust.yml` | `cargo fmt --check`, `cargo clippy` (warnings are errors) | `Cargo.toml` |
| `workflows/lint-typescript.yml` | `tsc --noEmit` after `npm ci` | `package.json` and `package-lock.json` |
| `workflows/lint-shell-yaml.yml` | ShellCheck on `*.sh`, yamllint on all YAML | Shell scripts or YAML |
| `workflows/compose-validate.yml` | Every Compose file resolves (`docker compose config`) | Compose files and their required variables |
| `workflows/gitleaks.yml` | Secrets in git history | Nothing extra |

## Use

```sh
cp path/to/git-shared-workflows/workflows/lint-python.yml .github/workflows/
git add .github/workflows/lint-python.yml && git commit -m "Add Python lint" && git push
```

Copy only the languages the repo uses. Each file is self-contained, and copies do not update when this repo changes.

Details for every file are in [ENVIRONMENT.md](ENVIRONMENT.md).
