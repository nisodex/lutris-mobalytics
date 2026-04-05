# Mobalytics Lutris Installer — Diablo IV

A [Lutris](https://lutris.net/) installer script for the [Mobalytics Desktop](https://mobalytics.gg) companion app, configured for **Diablo IV**.

This is derived from the community [mobalytics-standard](https://lutris.net/games/mobalytics/) installer (originally for League of Legends) by [tridoxx](https://lutris.net/games/mobalytics/) and helper scripts by [aleasto](https://gist.github.com/aleasto).

---

## ⚠️ Important Limitations

| Feature | Status |
|---|---|
| Mobalytics app launches | ✅ Works |
| Login (mobalytics:// URL scheme) | ✅ Works |
| 2nd Screen / builds browser | ✅ Works |
| **In-game overlay** | ❌ **Does NOT work on Linux** |

> The Mobalytics in-game overlay is incompatible with Wine/Linux. Use the **2nd screen** feature on a second monitor or device instead.

---

## Prerequisites

- **Lutris** installed
- **Diablo IV** already installed via Lutris (Battle.net prefix)
  - Default detected prefix: `~/.local/share/lutris/runners/wine/diablo-iv/` or a sibling `battle-net` prefix
- `zenity` installed (fallback folder picker)
  - `sudo apt install zenity` / `sudo dnf install zenity` / `sudo pacman -S zenity`
- `wine64`

---

## File Overview

| File | Purpose |
|---|---|
| `mobalytics-d4.yml` | Main Lutris installer script (YAML) |
| `find-d4.sh` | Locates your Diablo IV installation and writes the Mobalytics settings file |
| `mimehelper.sh` | Handles `mobalytics://` URLs (OAuth login callback) |
| `mobalytics.desktop` | Registers the `mobalytics://` URL scheme with your desktop |

---

## Installation

### Option A — Local install (recommended while testing)

```bash
lutris -i /path/to/mobalytics-d4.yml
```

### Option B — Via Lutris UI

1. Open Lutris → click the **+** button → **Install from a local install script**
2. Browse to `mobalytics-d4.yml`

---

## How It Works

1. Downloads and runs the official Mobalytics Windows installer via Wine.
2. Configures Wine DLL overrides needed for the .NET-based login flow.
3. Registers the `mobalytics://` URL scheme so clicking the login link in your browser is passed back into the Wine app.
4. Runs `find-d4.sh` which:
   - Looks for `Diablo IV.exe` in the sibling `battle-net` Lutris prefix (`../battle-net/drive_c/Program Files (x86)/Diablo IV/`)
   - Falls back to a `zenity` folder-picker dialog
   - Writes the Diablo IV path into Mobalytics' `settings.json`

---

## Diablo IV Detection Path

The script guesses your Diablo IV prefix as a sibling directory of the Mobalytics prefix named `battle-net`:

```
~/.local/share/lutris/runners/wine/
├── mobalytics/          ← Mobalytics prefix ($GAMEDIR)
└── battle-net/          ← Diablo IV / Battle.net prefix (auto-detected)
    └── drive_c/Program Files (x86)/Diablo IV/Diablo IV.exe
```

If your installation is elsewhere, the `zenity` picker will appear during install.

---

## Credits

- Original LoL installer: [tridoxx](https://lutris.net/games/mobalytics/)
- Helper scripts: [aleasto](https://gist.github.com/aleasto)
- D4 adaptation: nisodex
