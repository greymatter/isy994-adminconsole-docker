#!/bin/sh

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "Starting"

if [ -z "${ISY994_HOST}" ]; then
    echo "${RED}Please set a proper isy994 host with ISY994_HOST${NC}"
    sleep 2
    exit 1
fi

if [ -z "${ISY994_USER}" ]; then
    echo "${RED}Please set a proper isy994 user with ISY994_USER${NC}"
    sleep 2
    exit 1
fi

if [ -z "${ISY994_PASSWORD}" ]; then
    echo "${RED}Please set a proper isy994 password with ISY994_PASSWORD${NC}"
    sleep 2
    exit 1
fi

echo "Environment ok"

cd /app

if [ ! -f lib/admin.jnlp ]; then
    echo "Downloading admin.jnlp"

    wget -O admin.jnlp https://${ISY994_HOST}/admin.jnlp --no-check-certificate

    if [ ! $? -eq 0 ]; then
        echo "${RED}Failed to download admin.jnlp, please check your settings${NC}"
        sleep 2
        exit 2
    fi
fi

echo "${GREEN}Initialization complete, starting virtual console${NC}"

if [ -n "$IDRAC_KEYCODE_HACK" ]; then
    echo "Enabling keycode hack"

    export LD_PRELOAD=/keycode-hack.so
fi

exec javaws /app/admin.jnlp
