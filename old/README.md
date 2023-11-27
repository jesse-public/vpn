Prerequisites
-------------

`wg` for key generation


Usage
-----

1. Create and populate:
    - [ ] `.env`
    - [ ] `docker-compose.yml`

1. Populate `regenerate-keys.sh` with desired client and server information.

1. Generate server and client configs using `regenerate-keys.sh`.

1. Build the image:
```docker build -t vpn .```

1. Run the container:
```docker-compose up -d```


Additional commands
-------------------

Regenerating keys:
```./regenerate-keys.sh```

Showing client configs:
```./qr-code.sh configs/client/device.conf```

Removing client configs:
```rm configs/client/*.conf```
