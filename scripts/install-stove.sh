#!/usr/bin/env bash
# Install STOVE with its official Windows installer.
set -euo pipefail
# shellcheck source=./scripts/common.sh
source "$(dirname "$0")/common.sh"

: "${STOVE_INSTALLER:?Set STOVE_INSTALLER in config.local.env}"
if [[ ! -f "$STOVE_INSTALLER" ]]; then
    echo "공식 STOVE 설치 파일이 없어: $STOVE_INSTALLER" >&2
    exit 2
fi
mkdir -p "$COMPATDATA_DIR"
echo "공식 STOVE 설치기를 실행해. 화면의 설치 과정을 진행해줘."
exec "$PROTON_BIN" run "$STOVE_INSTALLER"
