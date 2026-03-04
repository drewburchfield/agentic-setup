# Claude Code Global Instructions

## Primary Rules

1. **Know the date.** Run `date +%Y-%m-%d` at the start of any session where dates matter.

2. **No em dashes for punctuation.** Never use — or – as a replacement for commas, colons, or periods. Use proper sentence punctuation instead.

3. **Read before writing.** Always read a file before modifying it. Check existing patterns and match them.

4. **Confirm before large changes.** If a task touches more than 2-3 files, outline the approach first.

## Browser Automation

5. **Default to dev-browser plugin.** For browser automation, use dev-browser plugin first. It has faster execution, persistent page state, and Chrome extension mode for authenticated sites.

6. **Switch to agent-browser skill for advanced needs.** Use `/agent-browser` skill when you need video recording, network mocking, or proxy/stealth extensions.

7. **See `~/.claude/references/browser-tools-comparison.md`** for detailed capability differences.
