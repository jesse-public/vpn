#!/usr/bin/env bash
sed -i s/iptables/iptables-nft/g volumes/wireguard/config/wg_confs/wg0.conf

