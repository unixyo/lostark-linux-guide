#!/usr/bin/env bash
# Launch installed STOVE with the tested GE-Proton prefix.
set -euo pipefail
# shellcheck source=./scripts/common.sh
source "$(dirname "$0")/common.sh"

STOVE_EXE="$COMPATDATA_DIR/pfx/drive_c/ProgramData/Smilegate/STOVE/STOVE.exe"
if [[ ! -f "$STOVE_EXE" ]]; then
    echo "STOVE.exe가 없어. install-stove.sh로 먼저 설치해줘: $STOVE_EXE" >&2
    exit 2
fi
cd "$(dirname "$STOVE_EXE")"
exec "$PROTON_BIN" run "$STOVE_EXE"
