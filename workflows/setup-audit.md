# Agentic Setup Audit

Reflects the skills.sh migration (skills managed cross-harness; `~/.agents/skills` canonical).

This repo should explain a working AI-agent environment from first principles, not just list a pile of local config. The goal is reproducibility: someone should understand what matters, what can drift, and what order to install things in.

## Layer 1: Operating Model

**Current state:** Five harnesses (Claude Code, Codex, Antigravity, OpenCode, Grok). Skills are managed by skills.sh, which installs to a canonical store at `~/.agents/skills/`. Codex, Antigravity, OpenCode, and Grok read from there directly (the universal path); Claude Code gets a symlink from `~/.claude/skills/`.

**Good pattern:** One tool, one canonical store, every harness. No homegrown sync layer and no privileged harness. `skills update` refreshes each skill from its source.

**Source of truth:** Personal skills live in a private repo; the public keep-set installs from public sources; the long tail is a `find-skills` backstop. Plugins remain Claude Code's domain. See [skills.md](../inventory/skills.md).

## Layer 2: Reproducibility

**Current state:** The README explains the setup and how skills.sh manages skills across harnesses. The inventory files describe what is installed today.

**Gap:** A new user can see the destination but not the full install order. Plugin marketplaces, personal skills, MCP servers, CLIs, and hooks are spread across several inventory files.

**Improvement:** Add a numbered bootstrap guide:

1. Install harnesses.
2. Install required CLIs.
3. Configure Claude Code settings and hooks.
4. Add plugin marketplaces.
5. Enable plugins.
6. Install skills with skills.sh (`skills add -a ...`); personal skills come from the private repo.
7. Run `npx skills list -g`.
8. Configure MCP servers per harness.
9. Run a health check.

## Layer 3: Drift Detection

**Current state:** `npx skills list -g` gives the most truthful skill graph. `inventory/skills.md` is a hand-curated reference and can drift between updates.

**Gap:** There is no committed check that says whether inventory is stale.

**Improvement:** Add a read-only health command later:

```bash
npx skills list -g
```

Then compare:

- current unique skill count
- personal skill count
- plugin skill count
- broken symlinks in secondary harnesses
- skills installed in some harnesses but missing in others

## Layer 4: Tutorial Quality

**Current state:** The repo is useful if you already understand Claude Code, plugins, MCP servers, and multiple harnesses.

**Gap:** It still reads more like an operator inventory than a tutorial.

**Improvement:** Add short conceptual pages before the detailed inventories:

- Why Claude Code hosts plugins, hooks, and commands (its irreducible domain).
- Why skills.sh installs each skill to every harness at once.
- How plugins differ from personal skills.
- What MCP servers do and which ones are shared.
- What to install first on a clean machine.

## Layer 5: Deepening Opportunities

### 1. Skill Graph Module

**Files:** `inventory/skills.md`

**Problem:** `skills list -g` is the live skill graph, but `inventory/skills.md` is hand-maintained and can drift from it.

**Solution:** skills.sh handles both install and read-only listing (`skills list -g`); the old sync-script split is resolved.

**Benefit:** Better locality. Inventory generation, stale checks, and sync can all depend on one skill graph interface.

### 2. Bootstrap Guide

**Files:** `README.md`, `config/`, `inventory/`

**Problem:** The setup path is scattered. A reader has to infer order from multiple files.

**Solution:** Add a `workflows/bootstrap.md` guide that walks from a clean machine to a verified setup.

**Benefit:** Higher leverage for the repo as a tutorial. The README can stay concise while the bootstrap guide carries the details.

### 3. Health Check

**Files:** `scripts/`, `inventory/`

**Problem:** The repo can silently drift from the machine.

**Solution:** Add a read-only `check` command that reports stale inventory, broken symlinks, and missing expected tools.

**Benefit:** Safer maintenance. The repo becomes easier to keep current without relying on memory.

## Current Recommendation

The skills.sh migration is done. Remaining conservative steps:

1. Keep skills.sh as the single skill manager; `~/.agents/skills/` is canonical, Claude Code symlinked in.
2. Refresh the inventory docs from `npx skills list -g` when they drift.
3. Add a future read-only health-check workflow instead of overbuilding automation today.
