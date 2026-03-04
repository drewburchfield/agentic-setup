# Git Configuration Reference

## Global Git Template

Every new repo (`git init` or `git clone`) automatically gets a pre-commit hook via git's template directory system.

**Config:** `~/.gitconfig`

```ini
[init]
    templateDir = ~/.git-templates
```

**Template hook:** `~/.git-templates/hooks/pre-commit`

The pre-commit hook runs three security checks on every commit across all repos:

1. **Credential pattern blocking** - Scans staged files for AWS keys (`AKIA...`), GitHub tokens (`ghp_`, `github_pat_`), GitLab tokens (`glpat-`), OpenAI keys (`sk-`), SendGrid keys, and JWTs. Blocks the commit if any are found.

2. **`.env` file warning** - Warns if `.env` or `.env.local` files are staged, with a confirmation prompt to proceed.

3. **Dependency audit** - Runs `npm audit --audit-level=high` when `package.json` or `package-lock.json` changes. Warns on high or critical vulnerabilities with a confirmation prompt.

## Reproducing

```bash
mkdir -p ~/.git-templates/hooks
cp ~/dev/agentic-setup/config/git/pre-commit ~/.git-templates/hooks/pre-commit
chmod +x ~/.git-templates/hooks/pre-commit
git config --global init.templateDir ~/.git-templates
```

Existing repos need the hook copied manually or re-cloned to pick up the template.
