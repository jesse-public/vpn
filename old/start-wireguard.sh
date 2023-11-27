#!/usr/bin/env bash

echo "*** starting wireguard interface $WG_INTERFACE ***"
wg-quick up $WG_INTERFACE

echo "*** waiting... ***"
tail -f /dev/null
