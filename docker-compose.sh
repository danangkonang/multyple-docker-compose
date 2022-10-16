#!/bin/sh

if [ "$2" = "--build" ]; then
  docker build -t heloword .
fi

buildComposeYaml() {
  cat <<HEADER
version: '3'
services:
HEADER
  for i in $(seq 1); do
    lng=${#i}
    cat <<BLOCK
  app-$i:
    image: heloword:latest
    environment:
      - MY_ENV=nothing
    ports:
BLOCK
    if [ $lng -lt 2 ]; then
      cat <<BLOCK
      - "5000$i:3000"
BLOCK
    fi
    if [ $lng -gt 1 ] && [ $lng -lt 3 ]; then
      cat <<BLOCK
      - "500$i:3000"
BLOCK
    fi
    if [ $lng -gt 2 ] && [ $lng -lt 4 ]; then
      cat <<BLOCK
      - "50$i:3000"
BLOCK
    fi
    if [ $lng -gt 3 ] && [ $lng -lt 5 ]; then
      cat <<BLOCK
      - "5$i:3000"
BLOCK
    fi
    cat <<BLOCK
    container_name: app-$i
    networks:
      - net
BLOCK
  done
cat <<BLOCK
networks:
  net:
BLOCK
}

buildComposeYaml | docker-compose -f- "$@"
