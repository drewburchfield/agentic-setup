# Claude Code Settings Reference

Settings file: `~/.claude/settings.json`

## Schema

```json
"$schema": "https://json.schemastore.org/claude-code-settings.json"
```

## Key Settings

| Setting | Value | Purpose |
|---------|-------|---------|
| `cleanupPeriodDays` | 99999 | Effectively disable auto-cleanup of sessions |
| `includeCoAuthoredBy` | false | Don't add co-authored-by to commits |
| `skipDangerousModePermissionPrompt` | true | Skip the dangerous mode confirmation |
| `effortLevel` | "medium" | Default reasoning effort level |

## Environment Variables

```json
"env": {
  "ANTHROPIC_BETA": "advanced-tool-use-2025-11-20"
}
```

## Permissions

### Allowed (auto-approved)

- **File operations:** Read, LS, Grep, Glob
- **Web:** WebSearch, WebFetch
- **MCP Resources:** ListMcpResourcesTool, ReadMcpResourceTool
- **Linear:** `mcp__linear__list_*`, `mcp__linear__get_*`, `mcp__linear__search_*`
- **Obsidian:** `mcp__obsidian__obsidian_get_*`, `mcp__obsidian__obsidian_list_*`, search tools
- **HelpScout:** `mcp__helpscout__search*`, `mcp__helpscout__get*`, `mcp__helpscout__list*`
- **Playwright:** browser_snapshot, browser_take_screenshot, browser_tab_list, browser_console_messages, browser_network_requests
- **Pencil:** `mcp__pencil`

### Denied

None explicitly denied.

## Hooks

### SessionStart

Runs `sync-skills.sh` silently to sync skills to other harnesses.

```json
"SessionStart": [{
  "hooks": [{
    "type": "command",
    "command": "zsh ~/.claude/scripts/sync-skills.sh > /dev/null 2>&1 || true"
  }]
}]
```

## MCP Servers (User-Level)

All user MCP servers are configured in `~/.claude.json` under the top-level `mcpServers` key. See [mcp-servers.md](../../inventory/mcp-servers.md) for the full list (10 user servers, 2 plugin MCPs).
