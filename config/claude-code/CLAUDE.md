# Claude Code Global Instructions

A starter `~/.claude/CLAUDE.md` based on rules that have held up across two years of daily use. Lift what's useful, skip what isn't. Personal voice, drafting templates, and project-specific guidance are left out so this is safe to copy into a fresh setup.

CLAUDE.md is loaded into every session as system context. Keep it short, keep it durable, only put things in here that you'd want true on every single task.

## Working Rules

1. **No em dashes for punctuation.** Never use `—` or `–` as a replacement for commas, colons, or periods. Use proper sentence punctuation instead. Most useful rule in the file for anyone who publishes anything Claude writes.

2. **Read before writing.** Always read a file before modifying it. Check existing patterns and match them.

3. **Confirm before large changes.** If a task touches more than 3 files, outline the approach first.

## Browser Automation

If you've installed a browser tool, tell Claude which one to reach for first. Otherwise it will pick differently every session.

4. **Claude-in-Chrome is the default.** Real browser, real logins, real session state. Use it for anything that touches authenticated sites or where you want to watch what's happening.

5. **dev-browser or agent-browser for programmatic control.** Use the dev-browser plugin when you need persistent page state, or the agent-browser skill when you need video recording, network mocking, or proxy/stealth extensions.

6. **Playwright for writing tests.** Use Playwright MCP only when the deliverable is a Playwright test suite, not for ad-hoc automation.

7. **See [references/browser-tools-comparison.md](../../references/browser-tools-comparison.md)** for the full capability matrix.

## Web Search

Same idea: name the preferred tool so Claude doesn't default to whichever it remembers first.

8. **Exa is the default for web search and fetch.** `mcp__exa__web_search_exa` and `mcp__exa__web_fetch_exa` over the built-in `WebSearch` / `WebFetch`. Better signal for technical and specific content.

9. **Google PSE for ranked links.** `mcp__Google-PSE__search` is the right tool for current events, mainstream queries, or triaging URLs to fetch.

10. **Exceptions:** Context7 for library and SDK docs, `gh` for GitHub URLs, authenticated MCPs for whichever services you've connected (Linear, HelpScout, Sentry, and so on).

## Documentation Lookups

11. **Context7 (`mcp__plugin_context7_context7__*`) for any library, framework, SDK, API, CLI tool, or cloud service.** Use it even when the answer feels obvious. Training data lags real-world API changes.

12. **DeepWiki via devin (`mcp__devin__read_wiki_structure`, `read_wiki_contents`, `ask_question`) for understanding public GitHub repos.** Faster than cloning and grepping.
