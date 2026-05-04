# Marketplaces Inventory

Current as of 2026-05-04. The plugin marketplaces this setup pulls from.

15 marketplaces feeding 74 plugins.

| Marketplace | Repository | Maintainer | Plugins drawn |
|-------------|------------|------------|---------------|
| anthropic-agent-skills | [drewburchfield/anthropic-skills](https://github.com/drewburchfield/anthropic-skills) (fork of [anthropics/skills](https://github.com/anthropics/skills)) | Anthropic | 3 |
| claude-canvas | [dvdsgl/claude-canvas](https://github.com/dvdsgl/claude-canvas) | David Siegel | 1 |
| claude-code-warp | [warpdotdev/claude-code-warp](https://github.com/warpdotdev/claude-code-warp) | Warp | 1 |
| claude-community | [kenryu42/claude-community](https://github.com/kenryu42/claude-community) (renamed from `cc-marketplace`) | kenryu42 | 1 |
| claude-plugins-official | bundled with Claude Code (no remote) | Anthropic | 30 |
| dbt-agent-marketplace | [dbt-labs/dbt-agent-skills](https://github.com/dbt-labs/dbt-agent-skills) | dbt Labs | 1 |
| dev-browser-marketplace | [sawyerhood/dev-browser](https://github.com/sawyerhood/dev-browser) | Sawyer Hood | 1 |
| dlthub-ai-workbench | [dlt-hub/dlthub-ai-workbench](https://github.com/dlt-hub/dlthub-ai-workbench) | dltHub | 3 |
| impeccable | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Paul Bakaus | 1 |
| knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Anthropic | 15 |
| linear-cli | [schpet/linear-cli](https://github.com/schpet/linear-cli) | schpet | 1 |
| not-my-job | [drewburchfield/not-my-job](https://github.com/drewburchfield/not-my-job) | drewburchfield | 11 |
| project-codeguard | [cosai-oasis/project-codeguard](https://github.com/cosai-oasis/project-codeguard) | Project CodeGuard | 1 |
| superpowers-marketplace | [obra/superpowers-marketplace](https://github.com/obra/superpowers-marketplace) | Jesse Vincent (obra) | 3 |
| superwhisper | [superultrainc/superwhisper-claude-code](https://github.com/superultrainc/superwhisper-claude-code) | Superwhisper | 1 |

## Notes

- Marketplaces auto-update via `git pull` when Claude Code checks for updates.
- `claude-plugins-official` is the largest source (30 plugins): Anthropic's official catalog spanning agents, hooks, LSPs, document tools, and writing styles.
- `not-my-job` is drewburchfield's personal marketplace (11 plugins) covering personal utilities and dev workflows.
- `knowledge-work-plugins` is Anthropic's role-based bundle (15 plugins): engineering, design, sales, finance, etc., each as composed tool sets.
- `claude-community` was previously named `cc-marketplace`. The local clone may still appear under both names during the transition.

## Adding a marketplace

```bash
claude plugin marketplace add <github-url>   # add a new marketplace
# Then enable individual plugins from that marketplace via Claude Code's plugin manager
```
