#!/usr/bin/env bash

if [ ! -f .env ]; then
    echo "Error: The .env file does not exist."
    exit 1
fi

set -o allexport
source .env
set +o allexport

if [[ "$1" == "--with-wg" ]]; then
    docker compose -f docker-compose.yaml -f docker-compose-wg.yaml up -d
else
    docker compose up -d
fi

sudo chown ${USER_ID}:${GROUP_ID} -R ${MEDIA_PATH}/media