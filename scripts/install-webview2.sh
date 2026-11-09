#!/usr/bin/env bash
# Install STOVE's bundled Microsoft Edge WebView2 bootstrapper when requested.
set -euo pipefail
# shellcheck source=./scripts/common.sh
source "$(dirname "$0")/common.sh"

installer="$COMPATDATA_DIR/pfx/drive_c/ProgramData/Smilegate/STOVE/MicrosoftEdgeWebview2Setup.exe"
if [[ ! -f "$installer" ]]; then
    echo "STOVE 제공 WebView2 설치기가 없어: $installer" >&2
    exit 2
fi
exec "$PROTON_BIN" run "$installer" /silent /install
