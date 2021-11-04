#!/usr/bin/env bash

if [ "$#" -ne 1 ]
then
  echo "Usage: ./show-qr configs/device.conf"
  exit 1
fi

qrencode -t ansiutf8 < $1
