Build the image:
```docker build -t vpn .```

Run the container:
```docker-compose up -d```

Regenerating keys:
```./generate-keys.sh```

Showing client configs:
```./show-qr.sh configs/client/device.conf```

Removing client configs:
```rm configs/client/*.conf```
