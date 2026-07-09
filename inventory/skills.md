# Skills Inventory

Skills are managed with [skills.sh](https://skills.sh) (`npx skills`). The canonical
copy of each skill lives in `~/.agents/skills/`; every harness (Claude Code, Codex,
Antigravity, OpenCode, Grok) reads from there, with Claude Code symlinked in.
`skills update` refreshes each skill from its source.

## How skills are sourced

**Personal skills** — authored or vendored, kept in a **private** repo and installed
across all harnesses via skills.sh:

```bash
npx skills add git@github.com:drewburchfield/skills.git --skill '*' -g \
  -a claude-code -a codex -a opencode -a antigravity -y
```

The private repo (`drewburchfield/skills`) is the source of truth for these and is not
enumerated here.

**Public keep-set** — installed from their public sources:

| Skill | Source |
|-------|--------|
| find-skills | [vercel-labs/skills](https://github.com/vercel-labs/skills) |
| ask-matt | [mattpocock/skills](https://github.com/mattpocock/skills) |
| codebase-design | [mattpocock/skills](https://github.com/mattpocock/skills) |
| domain-modeling | [mattpocock/skills](https://github.com/mattpocock/skills) |
| grill-me | [mattpocock/skills](https://github.com/mattpocock/skills) |
| grill-with-docs | [mattpocock/skills](https://github.com/mattpocock/skills) |
| grilling | [mattpocock/skills](https://github.com/mattpocock/skills) |
| handoff | [mattpocock/skills](https://github.com/mattpocock/skills) |
| implement | [mattpocock/skills](https://github.com/mattpocock/skills) |
| improve-codebase-architecture | [mattpocock/skills](https://github.com/mattpocock/skills) |
| prototype | [mattpocock/skills](https://github.com/mattpocock/skills) |
| setup-matt-pocock-skills | [mattpocock/skills](https://github.com/mattpocock/skills) |
| tdd | [mattpocock/skills](https://github.com/mattpocock/skills) |
| to-issues | [mattpocock/skills](https://github.com/mattpocock/skills) |
| to-prd | [mattpocock/skills](https://github.com/mattpocock/skills) |
| triage | [mattpocock/skills](https://github.com/mattpocock/skills) |
| bear-notes | [steipete/clawdis](https://github.com/steipete/clawdis) |
| nlm-skill | [jacob-bd/notebooklm-mcp-cli](https://github.com/jacob-bd/notebooklm-mcp-cli) |
| docx | [anthropics/skills](https://github.com/anthropics/skills) |
| pdf | [anthropics/skills](https://github.com/anthropics/skills) |
| pptx | [anthropics/skills](https://github.com/anthropics/skills) |
| xlsx | [anthropics/skills](https://github.com/anthropics/skills) |

**Backstop** — anything outside the keep-set is left to [`find-skills`](https://skills.sh),
which discovers and installs skills on demand. The long tail is not kept installed; it is
fetched the moment a task needs it.

**Plugin-provided skills** — many plugins ship their own skills (impeccable, plugin-dev,
codeguard-security, etc.). Those install through the plugin system, not skills.sh. See
[plugins.md](plugins.md).

## Day-to-day

```bash
# install a skill to all harnesses (GitHub shorthand, URL, or local path)
npx skills add <owner/repo> --skill <name> -g \
  -a claude-code -a codex -a opencode -a antigravity -y

# update everything
npx skills update -g

# find something on demand (the backstop)
npx skills find <query>

# list what's installed
npx skills list -g
```

## Notes

- Canonical store is `~/.agents/skills/`; the universal path covers Codex, OpenCode,
  Antigravity, and Grok. Claude Code gets a symlink from `~/.claude/skills/`.
- No homegrown sync layer. This repo previously used a `sync-skills.sh` SessionStart
  hook; that has been retired in favor of skills.sh native multi-agent installs.
