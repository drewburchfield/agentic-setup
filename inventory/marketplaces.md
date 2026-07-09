# Marketplaces Inventory

Current as of 2026-07-09. The plugin marketplaces this setup pulls from.

10 marketplaces feeding 31 plugins.

| Marketplace | Repository | Maintainer | Plugins drawn |
|-------------|------------|------------|---------------|
| claude-community | [anthropics/claude-plugins-community](https://github.com/anthropics/claude-plugins-community) | Anthropic | 1 |
| claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | Anthropic | 18 |
| dev-browser-marketplace | [sawyerhood/dev-browser](https://github.com/sawyerhood/dev-browser) | Sawyer Hood | 1 |
| fabric-collection | [microsoft/skills-for-fabric](https://github.com/microsoft/skills-for-fabric) | Microsoft | 2 |
| helpscout-mcp | [drewburchfield/help-scout-mcp-server](https://github.com/drewburchfield/help-scout-mcp-server) | drewburchfield | 0 |
| impeccable | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Paul Bakaus | 1 |
| linear-cli | [schpet/linear-cli](https://github.com/schpet/linear-cli) | schpet | 1 |
| not-my-job | [drewburchfield/not-my-job](https://github.com/drewburchfield/not-my-job) | drewburchfield | 6 |
| project-codeguard | [cosai-oasis/project-codeguard](https://github.com/cosai-oasis/project-codeguard) | Project CodeGuard | 1 |
| trailofbits | [trailofbits/skills](https://github.com/trailofbits/skills) | Trail of Bits | 0 |

## Notes

- Marketplaces auto-update via `git pull` when Claude Code checks for updates.
- `claude-plugins-official` is the largest source (18 plugins): Anthropic's official catalog spanning agents, hooks, LSPs, code review, and writing styles.
- `not-my-job` is drewburchfield's personal marketplace (6 plugins) covering personal utilities and dev workflows.
- `claude-community` resolves to [anthropics/claude-plugins-community](https://github.com/anthropics/claude-plugins-community), Anthropic's official community plugin catalog. Only `safety-net` is drawn from it here; that plugin's own source lives at [kenryu42/claude-code-safety-net](https://github.com/kenryu42/claude-code-safety-net).
- The document skills (docx, pdf, pptx, xlsx) come from [anthropics/skills](https://github.com/anthropics/skills) via skills.sh, not through a marketplace. See [skills.md](skills.md).

## Adding a marketplace

```bash
claude plugin marketplace add <github-url>   # add a new marketplace
# Then enable individual plugins from that marketplace via Claude Code's plugin manager
```
