#!/usr/bin/env bash

if [ ! -f .env ]; then
    echo "Error: The .env file does not exist."
    exit 1
fi

docker compose up -d

sudo chown ${USER_ID}:${GROUP_ID} -R ${MEDIA_PATH}