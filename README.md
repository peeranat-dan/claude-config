# claude-config

Personal Claude Code configuration - hooks, status line, and settings.

## Contents

| File | Description |
|------|-------------|
| `settings.json` | Global Claude Code settings (telemetry, permissions, hooks, status line) |
| `statusline-command.sh` | Status line script showing context window usage and model name |
| `hooks/block-env-access.js` | PreToolUse hook that blocks Claude from reading `.env` files |
| `setup.sh` | Setup script for macOS / Linux |
| `setup.ps1` | Setup script for Windows |

## Setup

The setup scripts copy all config files to `~/.claude/` and rewrite placeholder paths to your actual home directory.

### macOS / Linux

```sh
./setup.sh
```

### Windows (PowerShell)

```powershell
.\setup.ps1
```

## What gets installed

```
~/.claude/
├── settings.json
├── statusline-command.sh
└── hooks/
    └── block-env-access.js
```

## Notes

- `settings.json` contains a `YOUR_USERNAME` placeholder in hook command paths. The setup scripts replace it with your actual home directory automatically.
- Re-running setup is safe - files are overwritten in place.