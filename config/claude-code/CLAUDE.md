# Claude Code Global Instructions

Public-safe rules for `~/.claude/CLAUDE.md`. Personal voice and drafting templates are kept out so this is safe to copy into a fresh setup. For the reasoning behind these tool choices, see [workflows/README.md](../../workflows/README.md).

## Primary Rules

1. **No em dashes for punctuation.** Never use `—` or `–` as a replacement for commas, colons, or periods. Use proper sentence punctuation instead.

2. **Read before writing.** Always read a file before modifying it. Check existing patterns and match them.

3. **Confirm before large changes.** If a task touches more than 3 files, outline the approach first.

## Browser Automation

4. **Claude-in-Chrome is the default.** Use it for authenticated sites and anything a human should watch.

5. **dev-browser or agent-browser for programmatic control.** dev-browser for persistent page state; agent-browser for video recording, network mocking, or proxy/stealth extensions.

6. **Playwright only for writing test suites.**

7. **See [references/browser-tools-comparison.md](../../references/browser-tools-comparison.md)** for the capability matrix.

## Web Search

8. **Exa is the default for web search and fetch.** `mcp__exa__web_search_exa` and `mcp__exa__web_fetch_exa` over built-in `WebSearch` / `WebFetch`.

9. **Google PSE for ranked links.** `mcp__Google-PSE__search` for current events, mainstream queries, or triaging URLs to fetch.

10. **Exceptions:** Context7 for library and SDK docs, `gh` for GitHub URLs, authenticated MCPs for connected services (Linear, HelpScout, Sentry, and so on).

## Documentation Lookups

11. **Context7 (`mcp__plugin_context7_context7__*`) for any library, framework, SDK, API, CLI tool, or cloud service.**

12. **DeepWiki via devin (`mcp__devin__read_wiki_structure`, `read_wiki_contents`, `ask_question`) for public GitHub repos.**
