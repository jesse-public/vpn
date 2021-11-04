#!/usr/bin/env bash

echo "WARNING: Run on secure machine and then transfer configs to server and peers!"

ServerEndpoint="domain.duckdns.org";
DNS="9.9.9.9, 9.9.9.9";
ClientNames=('mac' 'pc' 'linux' 'phone');
ServerNames=('server');
PORT="51820";
BaseIP="10.7.0.";
ClientIPSuffix=2;
ServerIP=${BaseIP}1;

sudo rm ./configs/*.conf
rm -rf keys
mkdir keys

DeviceNames=("${ClientNames[@]}" "${ServerNames[@]}");

for DeviceName in ${DeviceNames[@]}
do
  echo "Generating keys for $DeviceName..." &&
  umask 077 &&
  wg genkey > keys/${DeviceName}.privatekey &&
  wg pubkey < keys/${DeviceName}.privatekey > keys/${DeviceName}.publickey &&
  wg genpsk > keys/${DeviceName}.presharedkey
done

echo "Creating server.conf..."
cat > configs/server.conf << EOL
[Interface]
PrivateKey = $(cat keys/server.privatekey)
Address = ${ServerIP}/24
ListenPort = ${PORT}
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

EOL

for ClientName in ${ClientNames[@]}
do
  ClientIP=${BaseIP}${ClientIPSuffix}
  cat >> configs/server.conf << EOL
### begin ${ClientName} ###
[Peer]
PublicKey = $(cat keys/${ClientName}.publickey)
PresharedKey = $(cat keys/${ClientName}.presharedkey)
AllowedIPs = ${ClientIP}/32
### end ${ClientName} ###

EOL

  echo "Creating ${ClientName}.conf..."
  cat > configs/${ClientName}.conf << EOL
[Interface]
Address = ${ClientIP}
PrivateKey = $(cat keys/${ClientName}.privatekey)
DNS = ${DNS}

[Peer]
PublicKey = $(cat keys/server.publickey)
PresharedKey = $(cat keys/${ClientName}.presharedkey)
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = ${ServerEndpoint}:${PORT}
EOL
  chmod 0600 configs/${ClientName}.conf
  ((ClientIPSuffix++));
done

rm -rf keys
