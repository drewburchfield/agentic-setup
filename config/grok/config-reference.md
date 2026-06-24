# Grok Configuration Reference

xAI's `grok` CLI (v0.2.x).

## Config

**File:** `~/.grok/config.toml`

```toml
[ui]
permission_mode = "always-approve"

[models]
default = "grok-build"

[marketplace]
official_marketplace_auto_installed = true

[[marketplace.sources]]
name = "xAI Official"
git = "https://github.com/xai-org/plugin-marketplace.git"
```

| What | Path |
|------|------|
| CLI | `grok` (`~/.grok/bin/`) |
| Config | `~/.grok/config.toml` |
| Auth | `~/.grok/auth.json` |
| MCP logs | `~/.grok/logs/mcp/` |

## Models

Default model `grok-build` (the secondary fork model is also `grok-build`).

## Plugin Marketplace

Grok has its **own** plugin marketplace ([xai-org/plugin-marketplace](https://github.com/xai-org/plugin-marketplace)),
auto-installed. This is separate from Claude Code's marketplaces.

## Skills

Installed by [skills.sh](https://skills.sh); Grok reads the **universal** `~/.agents/skills/` path.
No `-a grok` flag is needed; installing to any universal-path agent (e.g. `-a codex`) populates
`~/.agents/skills/`, which Grok reads. See [skills.md](../../inventory/skills.md).

## MCP Servers

Grok runs a broad MCP set (Docker MCP gateway + search, image, notes, and personal servers).
See [mcp-servers.md](../../inventory/mcp-servers.md) for the generalized list (client/personal
servers are not enumerated by name).
