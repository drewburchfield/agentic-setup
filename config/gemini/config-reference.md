# Gemini CLI Configuration Reference

**Config file:** `~/.gemini/settings.json`

## Settings

```json
{
  "security": {
    "auth": {
      "selectedType": "oauth-personal"
    }
  },
  "general": {
    "previewFeatures": true
  }
}
```

## MCP Servers

| Server | Command | Args |
|--------|---------|------|
| MCP_DOCKER | `docker` | `mcp gateway run` |
| Playwright | `npx` | `-y @playwright/mcp@latest` |

Playwright requires explicit PATH to Node:
```json
"env": {
  "PATH": "/opt/homebrew/opt/nvm/versions/node/<your-version>/bin:/opt/homebrew/bin:/usr/bin:/bin"
}
```

## Skills

Skills are symlinked from Claude Code via `sync-skills.sh` into `~/.gemini/skills/`.

## Global Instructions

`~/.gemini/GEMINI.md` provides global instructions (equivalent to Claude's CLAUDE.md).

## Other Files

- `extensions/` - Gemini CLI extensions
- `antigravity/` - Antigravity extension
- `antigravity-browser-profile/` - Browser profile for Antigravity
