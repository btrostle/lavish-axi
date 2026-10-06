#!/usr/bin/env bash
# Runs lavish-axi configured for a Docker sbx sandbox reviewed from the VLAN.
set -euo pipefail

LAVISH_VERSION="0.1.83"
LINK_HOST="dev.home"

name="${SANDBOX_NAME:-$(hostname)}"
ip="$(hostname -I | awk '{print $1}')"
# Must match lavish-publish on the host: stable per-sandbox port in 40000-49999.
port=$(( 40000 + $(printf '%s' "$name" | cksum | awk '{print $1}') % 10000 ))

export LAVISH_AXI_HOST="$ip"
export LAVISH_AXI_PORT="$port"
export LAVISH_AXI_ALLOWED_HOSTS="$LINK_HOST"
export LAVISH_AXI_LINK_HOST="$LINK_HOST"
export LAVISH_AXI_NO_OPEN=1
export NO_PROXY="${NO_PROXY:+$NO_PROXY,}$ip"
export no_proxy="$NO_PROXY"

exec npx -y "lavish-axi@$LAVISH_VERSION" "$@"
