Build the image:
```docker build -t vpn .```

Run the container:
```docker-compose up -d```

Regenerating keys:
```./regenerate-keys.sh```

Showing client configs:
```./qr-code.sh configs/client/device.conf```

Removing client configs:
```rm configs/client/*.conf```
