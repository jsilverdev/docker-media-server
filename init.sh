#!/usr/bin/env bash

set -euo pipefail

if [ ! -f .env ]; then
  echo "Error: The .env file does not exist."
  exit 1
fi

set -a
source default.env
source .env
set +a


: "${PUID:?PUID is not set}"
: "${PGID:?PGID is not set}"
: "${MEDIA_PATH:?MEDIA_PATH is not set}"
: "${MEDIA_SERVER_PATH:?MEDIA_SERVER_PATH is not set}"

mkdir -p "$MEDIA_PATH"
mkdir -p "$MEDIA_SERVER_PATH"

docker compose up -d

sudo chown -R "${PUID}:${PGID}" "$MEDIA_PATH"
