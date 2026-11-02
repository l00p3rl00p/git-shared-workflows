# git-shared-workflows

Boring engineering checks as GitHub Actions workflows. Copy the files you want into a repo's `.github/workflows/` folder. Nothing here runs by itself.

| File | Checks | Triggers |
| --- | --- | --- |
| `workflows/ruff.yml` | Python lint and format (`ruff check`, `ruff format --check`) | push to main, manual |
| `workflows/shellcheck.yml` | Shell scripts (`shellcheck`) | push to main, manual |
| `workflows/yaml-lint.yml` | YAML syntax and style (`yamllint`) | push to main, manual |
| `workflows/compose-validate.yml` | Every Compose file resolves (`docker compose config`) | push to main, manual |
| `workflows/gitleaks.yml` | Secrets in git history (gitleaks) | push to main, manual |

## Use

```sh
cp path/to/git-shared-workflows/workflows/ruff.yml .github/workflows/
git add .github/workflows/ruff.yml && git commit -m "Add ruff check" && git push
```

Each file is self-contained. Copies do not update when this repo changes.

## Rules

- Checks report; they never change code.
- Each run is cancelled by a newer run on the same branch.
- Nothing here needs a secret except the built-in `GITHUB_TOKEN`.
- Pins only when something forces one. Otherwise the latest tool is used.
