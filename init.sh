#!/usr/bin/env bash

if [ ! -f .env ]; then
    echo "Error: The .env file does not exist."
    exit 1
fi

PUID=$(id -u)
USER_ID_EXISTS=$(grep -E '^USER_ID' .env)
if [ -n "$USER_ID_EXISTS" ]; then
    sed -i "s/^USER_ID.*/USER_ID=$PUID/g" .env
else
    printf "\nUSER_ID=$PUID" >> .env
fi

PGID=$(id -g)
GROUP_ID_EXISTS=$(grep -E '^GROUP_ID' .env)
if [ -n "$GROUP_ID_EXISTS" ]; then
    sed -i "s/^GROUP_ID.*/GROUP_ID=$PGID/g" .env
else
    printf "\nGROUP_ID=$PGID" >> .env
fi

set -o allexport
source .env
set +o allexport

docker compose up -d

sudo chown ${USER_ID}:${GROUP_ID} -R ${MEDIA_PATH}