#!/usr/bin/env bash

docker image pull alpine
docker build -t vpn .
docker-compose up -d
docker image prune -f

