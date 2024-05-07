#!/bin/bash -ex

docker compose -f docker/compose.yaml --env-file docker/.env up -d
