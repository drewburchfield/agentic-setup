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

### PreToolUse (Bash): zero auto-approve

Auto-approves [Zero CLI](https://zero.xyz) calls so `zero` runs without a permission prompt.

```json
"PreToolUse": [{
  "matcher": "Bash",
  "hooks": [{ "type": "command", "command": "~/.zero/hooks/auto-approve-zero.sh" }]
}]
```

> **Skills are managed by [skills.sh](https://skills.sh), not a hook.** The previous
> `SessionStart` `sync-skills.sh` hook (cross-harness symlink sync) has been **retired** in
> favor of skills.sh native multi-agent installs. The `UserPromptSubmit` zero-context
> injector was also removed (it pushed Zero context into every prompt); Zero is now invoked
> on demand.

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
