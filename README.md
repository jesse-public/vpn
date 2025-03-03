VPN
===

##Installation notes

###Secrets

Ensure newlines are not appended to secret files:
```
echo -n "my-secret" > secrets/cloudflare_api_token
```

###Rocky Linux

On Rocky Linux 9 (and other RHEL), iptables is replaced by nftables. After generating configuration, run the following script to use iptables-nft:
```
./use-nft-rocky-linux.sh
```

Also, firewalld may need to be configured or disabled if containers cannot access the internet.

##Showing a peer QR code
```
docker exec -it wireguard /app/show-peer laptop
```
