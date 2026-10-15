#!/bin/sh
set -eu
cd "$(dirname "$0")"

token=$(sed -n 's/^GHCR_TOKEN=//p' .env)
if [ -n "$token" ]; then
  printf '%s' "$token" | docker login ghcr.io -u "$(sed -n 's/^GHCR_USER=//p' .env)" --password-stdin > /dev/null
fi
docker compose pull
docker compose up -d --remove-orphans
