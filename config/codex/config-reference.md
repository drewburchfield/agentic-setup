# Codex CLI Configuration Reference

**Config file:** `~/.codex/config.toml`

## Settings

```toml
model = "gpt-5.3-codex"
personality = "pragmatic"
model_reasoning_effort = "medium"
```

## MCP Servers

| Server | Type | Command/URL |
|--------|------|-------------|
| MCP_DOCKER | command | `docker mcp gateway run` |
| Playwright | command | `npx @playwright/mcp@latest` |
| pencil | command | Pencil app bundled MCP server binary |
| linear | url | `https://mcp.linear.app/mcp` |

Playwright requires explicit PATH:
```toml
[mcp_servers.Playwright.env]
PATH = "/opt/homebrew/opt/nvm/versions/node/<your-version>/bin:/opt/homebrew/bin:/usr/bin:/bin"
```

## Trusted Projects

Multiple project directories are marked as `trust_level = 'trusted'`.

## Skills

Skills are symlinked from Claude Code via `sync-skills.sh` into `~/.codex/skills/`.

## Other Files

- `rules/` - Codex instruction rules
- `sessions/` - Session history
- `history.jsonl` - Command history
