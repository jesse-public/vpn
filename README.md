VPN
===

Installation notes
---
Note: On Rocky Linux 9 (and other RHEL), iptables is replaced by nftables. After generating configuration, run the following script to use iptables-nft:
```
./use-nft-rocky-linux.sh
```

Showing a peer QR code
---
```
docker exec -it wireguard /app/show-peer laptop
```
