# Claude Code Settings Reference

A starter configuration for `~/.claude/settings.json`, based on what's worked for me across two years of daily use. Lift what's useful, skip what isn't.

Official reference: [code.claude.com/docs/en/settings](https://code.claude.com/docs/en/settings).

## Schema

Add the schema line to get autocomplete and validation in editors that support it:

```json
"$schema": "https://json.schemastore.org/claude-code-settings.json"
```

## Top-Level Settings Worth Knowing

| Setting | Suggested | What it does |
|---------|-----------|--------------|
| `cleanupPeriodDays` | `99999` | Effectively disables auto-cleanup of sessions. Useful if you ever want to scroll back through history. |
| `includeCoAuthoredBy` | `false` | Keeps Claude out of your commit metadata. |
| `effortLevel` | `"high"` or `"medium"` | Default reasoning effort. `high` is slower but better for tricky work. |
| `agentPushNotifEnabled` | `true` | OS notifications when long-running agents finish. |

## Permissions

The single most useful thing to configure early. Two parts: a `defaultMode` that sets the baseline, and `allow` / `deny` lists for fine-grained rules.

### Recommended mode: `auto`

```json
"permissions": {
  "defaultMode": "auto",
  "allow": [ "..." ],
  "deny":  [ "..." ]
}
```

Other valid values: `default`, `acceptEdits`, `plan`, `dontAsk`, `bypassPermissions`. As of Claude Code v2.1.142, `auto` must be set in `~/.claude/settings.json` specifically, it's ignored in project or local settings. See the [permission modes docs](https://code.claude.com/docs/en/permission-modes) for current behavior of each.

### Allow list: start with read-only tools

A good starting `allow` list covers anything that reads but doesn't write. Patterns I use:

```json
"allow": [
  "Read", "LS", "Grep", "Glob",
  "WebSearch", "WebFetch",
  "ListMcpResourcesTool", "ReadMcpResourceTool"
]
```

For each MCP you add, consider allowlisting its read-only methods. Examples from my setup, adapt to whatever MCPs you install:

- Linear: `mcp__linear__list_*`, `mcp__linear__get_*`, `mcp__linear__search_*`
- Sentry: `mcp__Sentry__list_*`, `mcp__Sentry__get_*`, `mcp__Sentry__search_*`
- HelpScout: `mcp__helpscout__search*`, `mcp__helpscout__get*`, `mcp__helpscout__list*`
- Playwright (read-only): `browser_snapshot`, `browser_take_screenshot`, `browser_tab_list`, `browser_console_messages`, `browser_network_requests`

The pattern is the same: name a server, list its read shapes. Don't allowlist writes.

### Deny list: irreversible commands

Worth seeding even if you start small. Things you'd never want auto-approved:

```json
"deny": [
  "Bash(rm -rf *)",
  "Bash(git push --force *)",
  "Bash(curl * | sh)",
  "Read(./.env)",
  "Read(./.env.*)"
]
```

See the [security baseline](../../workflows/security-baseline.md) for the broader posture.

## Environment Variables

```json
"env": {
  "ANTHROPIC_BETA": "advanced-tool-use-2025-11-20",
  "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE": "50"
}
```

`CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` triggers context compaction earlier than the default. Setting it to 50 means Claude compacts at half the context window instead of waiting until near the limit, which keeps long sessions responsive.

## Hooks

Hooks run shell commands at lifecycle events. The most useful starter hook is `SessionStart` for setup tasks. Example from this repo:

```json
"hooks": {
  "SessionStart": [{
    "hooks": [{
      "type": "command",
      "command": "zsh ~/.claude/scripts/sync-skills.sh > /dev/null 2>&1 || true"
    }]
  }]
}
```

The `|| true` keeps a script failure from blocking the session. Full event list and patterns in [hooks.md](hooks.md).

## Status Line

Custom status line at the bottom of the terminal. Point at any script that prints a single line of output:

```json
"statusLine": {
  "type": "command",
  "command": "~/.claude/statusline.sh",
  "padding": 0
}
```

## Sandbox

`sandbox.network.allowedDomains` restricts outbound network for sandboxed tool calls. Keep this tight to whatever domains your tooling actually needs:

```json
"sandbox": {
  "network": {
    "allowedDomains": ["example.com"]
  }
}
```

## Enabled Plugins and Marketplaces

Configured via `enabledPlugins` and `extraKnownMarketplaces`. The canonical lists for this setup live at [inventory/plugins.md](../../inventory/plugins.md) and [inventory/marketplaces.md](../../inventory/marketplaces.md).

## MCP Servers (user-level)

User MCP servers live in `~/.claude.json` under the top-level `mcpServers` key, not in `settings.json`. See [mcp-servers.md](../../inventory/mcp-servers.md) for the full list.
