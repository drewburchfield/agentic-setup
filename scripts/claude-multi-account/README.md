# Claude multi-account + cmux resume scripts

Portable pieces for the pattern in
[workflows/cmux-claude-multi-account-resume.md](../../workflows/cmux-claude-multi-account-resume.md).

**Parallel sticky seats**, not account switching: each cmux tab keeps the login
it was started with (main or additional).

| File | Purpose |
|------|---------|
| `claude-profile` | Generic launcher for an **additional** account; symlink as `<name>-claude` |
| `cmux-claude-profile-dispatch` | Set as cmux `automation.claudeBinaryPath` |
| `cmux-claude-profile-record` | Claude SessionStart/Stop hook (records session → profile) |
| `install.sh` | Installs the above, wires settings + cmux.json |

```bash
./install.sh account-1 account-2
account-1-claude --share-history   # additional account 1
claude                             # main account (unchanged)
```
