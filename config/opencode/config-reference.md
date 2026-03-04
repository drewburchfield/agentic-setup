# OpenCode Configuration Reference

**Config file:** `~/.config/opencode/opencode.json`

## MCP Servers

| Server | Type | Description |
|--------|------|-------------|
| MCP_DOCKER | local | Docker MCP Toolkit gateway (`docker mcp gateway run`) |
| zai-vision | local | Z.AI vision model via `npx @z_ai/mcp-server` |
| zai-search | remote | Z.AI web search prime (`api.z.ai`) |
| zai-reader | remote | Z.AI web reader (`api.z.ai`) |
| zai-zread | remote | Z.AI deep read / zread (`api.z.ai`) |

## Config Format

OpenCode uses a JSON config with `$schema: "https://opencode.ai/config.json"`:

```json
{
  "mcp": {
    "<server-name>": {
      "type": "local" | "remote",
      "command": ["cmd", "arg1", "arg2"],
      "environment": { "KEY": "value" },
      "enabled": true
    }
  }
}
```

Remote servers use `url` and optional `headers` instead of `command`.

## Skills

Skills are symlinked from Claude Code via `sync-skills.sh` into `~/.config/opencode/skills/`.

## File Locations

- Config: `~/.config/opencode/opencode.json`
- Node modules: `~/.config/opencode/node_modules/` (plugin SDK, zod)
