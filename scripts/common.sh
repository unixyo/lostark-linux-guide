#!/usr/bin/env bash
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="${LOSTARK_CONFIG:-$REPO_ROOT/config.local.env}"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "설정 파일이 없어: $CONFIG_FILE" >&2
    echo "config.example.env를 config.local.env로 복사하고 경로를 수정해줘." >&2
    exit 2
fi

# shellcheck disable=SC1090
source "$CONFIG_FILE"

: "${PROTON_BIN:?Set PROTON_BIN in the config file}"
: "${COMPATDATA_DIR:?Set COMPATDATA_DIR in the config file}"
: "${STEAM_CLIENT_DIR:?Set STEAM_CLIENT_DIR in the config file}"
: "${GAME_MOUNT:?Set GAME_MOUNT in the config file}"
: "${GAME_WIN_PATH:?Set GAME_WIN_PATH in the config file}"

if [[ ! -f "$PROTON_BIN" ]]; then
    echo "Proton 실행기가 없어: $PROTON_BIN" >&2
    exit 2
fi

export STEAM_COMPAT_DATA_PATH="$COMPATDATA_DIR"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$STEAM_CLIENT_DIR"
export STEAM_COMPAT_APP_ID=0
export LANG=ko_KR.UTF-8
export LC_ALL=ko_KR.UTF-8
