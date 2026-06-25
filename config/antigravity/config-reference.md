# Antigravity (`agy`) Configuration Reference

Antigravity is Google's agentic IDE (a VS Code fork) running **Gemini models**. The `agy` CLI
drives it from the terminal. It replaces the standalone Gemini CLI in this setup.

## Locations

| What | Path |
|------|------|
| CLI | `~/.local/bin/agy` |
| App config | `~/.antigravity/` (`argv.json`, `extensions/`) |
| Agent data | `~/.gemini/antigravity/` (brain, context state, browser recordings) |
| MCP config | `~/.gemini/antigravity/mcp_config.json` |
| Skills | `~/.agents/skills/` (universal; its own `~/.gemini/antigravity/skills/` is unused) |

## Models

Gemini models (Google), via the Antigravity runtime.

## Skills

Installed by [skills.sh](https://skills.sh) into `~/.agents/skills/` (universal; its own `~/.gemini/antigravity/skills/` is unused):

```bash
npx skills add <source> -g -a antigravity
```

In practice skills install to every harness at once; see [skills.md](../../inventory/skills.md).

## MCP Servers

Configured in `~/.gemini/antigravity/mcp_config.json` (standard `mcpServers` JSON).
**Currently empty.** Antigravity relies on its built-in tooling. See
[mcp-servers.md](../../inventory/mcp-servers.md).
