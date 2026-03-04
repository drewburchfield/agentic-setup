# Claude Code Hooks Reference

## Available Hook Events

| Event | When It Fires |
|-------|--------------|
| `SessionStart` | Before first user message is processed |
| `SessionEnd` | When session ends |
| `Stop` | After Claude finishes a response |
| `PreToolUse` | Before a tool executes |
| `PostToolUse` | After a tool executes |
| `SubagentStop` | After a subagent finishes |
| `UserPromptSubmit` | When user submits a prompt |
| `PreCompact` | Before context compression |
| `Notification` | When a notification fires |

## Active Hooks

### SessionStart: sync-skills.sh

Syncs all Claude Code skills (personal + plugin) to Gemini, Codex, and OpenCode via symlinks.

```json
"SessionStart": [{
  "hooks": [{
    "type": "command",
    "command": "zsh ~/.claude/scripts/sync-skills.sh > /dev/null 2>&1 || true"
  }]
}]
```

- Silent execution (stdout/stderr suppressed)
- `|| true` prevents script failure from blocking session startup
- Script is a symlink to `~/dev/agentic-setup/scripts/sync-skills.sh`

## Hook Format

Hooks are defined in `settings.json` under the `hooks` key:

```json
{
  "hooks": {
    "<EventName>": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "shell command here"
          }
        ]
      }
    ]
  }
}
```

## Plugin Hooks

Plugins can also define hooks in their `hooks.json` files. These use `${CLAUDE_PLUGIN_ROOT}` for paths (not `$PLUGIN_DIR`).
