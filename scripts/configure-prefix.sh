#!/usr/bin/env bash
# Connect the Windows D: game partition and import the STOVE/Wine registry values.
set -euo pipefail
# shellcheck source=./scripts/common.sh
source "$(dirname "$0")/common.sh"

dosdevices="$COMPATDATA_DIR/pfx/dosdevices"
drive_c="$COMPATDATA_DIR/pfx/drive_c"
if [[ ! -d "$dosdevices" || ! -d "$drive_c" ]]; then
    echo "Wine prefix가 초기화되지 않았어. install-stove.sh부터 진행해줘." >&2
    exit 2
fi
if [[ ! -d "$GAME_MOUNT" ]]; then
    echo "게임 드라이브 마운트가 없어: $GAME_MOUNT" >&2
    exit 2
fi
if [[ ! "$GAME_WIN_PATH" =~ ^[Dd]:\\ ]]; then
    echo "이 예제는 D: 게임 경로만 지원해. GAME_WIN_PATH를 확인해줘." >&2
    exit 2
fi

drive_link="$dosdevices/d:"
if [[ -L "$drive_link" ]]; then
    current="$(readlink -f "$drive_link")"
    wanted="$(readlink -f "$GAME_MOUNT")"
    if [[ "$current" != "$wanted" ]]; then
        echo "기존 D:가 다른 경로를 가리켜: $current" >&2
        exit 2
    fi
elif [[ -e "$drive_link" ]]; then
    echo "기존 D: 항목을 덮어쓰지 않을게: $drive_link" >&2
    exit 2
else
    ln -s "$GAME_MOUNT" "$drive_link"
fi

escaped_game_path="${GAME_WIN_PATH//\\/\\\\}"
game_reg="$(mktemp "$drive_c/stove-game-XXXXXX.reg")"
focus_reg="$(mktemp "$drive_c/stove-focus-XXXXXX.reg")"
trap 'rm -f "$game_reg" "$focus_reg"' EXIT

cat > "$game_reg" <<EOF
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\SGUP\Apps\45]
"GamePath"="$escaped_game_path"
EOF
cp "$REPO_ROOT/registry/wine-focus.reg" "$focus_reg"

# Use C: paths because both files live directly under drive_c/.
"$PROTON_BIN" run reg.exe import "C:\\$(basename "$game_reg")"
"$PROTON_BIN" run reg.exe import "C:\\$(basename "$focus_reg")"
echo "D: 연결, GamePath와 UseTakeFocus=N 설정이 등록됐어."
