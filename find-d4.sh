#!/bin/bash
# find-d4.sh - Locates the Diablo IV installation for Mobalytics
# Based on find-lol.sh by aleasto (https://gist.github.com/aleasto)
# Adapted for Diablo IV by lutris-mobalytics contributors

[ -z $GAMEDIR ] && GAMEDIR="$1"
[ -z $WINEBIN ] && WINEBIN="$2"

export GTK_USE_PORTAL=0
export WINE="$WINEBIN"
export WINEPREFIX="$GAMEDIR"

# Guess the Diablo IV installation path (typical Lutris Battle.net prefix location)
D4_PREFIX=$(realpath "$GAMEDIR/../battle-net")
D4_CLIENT="drive_c/Program Files (x86)/Diablo IV/Diablo IV.exe"

if [ -f "$D4_PREFIX/$D4_CLIENT" ]; then
    D4_DIR=$(dirname "$D4_PREFIX/$D4_CLIENT")
elif command -v zenity >/dev/null; then
    D4_PREFIX=$(zenity --file-selection --directory --filename="$GAMEDIR/../" --title="Select your Diablo IV prefix" 2>/dev/null)
    [ $? -eq 0 ] || exit
    if [ -f "$D4_PREFIX/$D4_CLIENT" ]; then
        D4_DIR=$(dirname "$D4_PREFIX/$D4_CLIENT")
    else
        EXE=$(zenity --file-selection --file-filter="Diablo IV.exe" --filename="$D4_PREFIX/$D4_CLIENT" --title="Find Diablo IV.exe" 2>/dev/null)
        [ $? -eq 0 ] || exit
        D4_DIR=$(dirname "$EXE")
    fi
fi

[ ! -d "$D4_DIR" ] && exit 1

WINDOWS_PATH=$(${WINE}path --windows "$D4_DIR" 2>/dev/null)
SETTINGS_FILE="$GAMEDIR/drive_c/users/$(whoami)/AppData/Roaming/mobalytics-desktop/settings.json"
mkdir -p $(dirname "$SETTINGS_FILE")
echo "{\"game-folder-path\":\"${WINDOWS_PATH//\\/\\\\}\"}" > "$SETTINGS_FILE"
