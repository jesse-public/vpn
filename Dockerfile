FROM alpine

RUN \
  echo "*** installing dependencies ***" && \
  apk update --no-cache && \
  apk add -U wireguard-tools && \
  apk upgrade --no-cache && \
  rm -rf /var/cache/apk/*

COPY ./wg0.conf /etc/wireguard/wg0.conf

RUN chmod 0600 /etc/wireguard/wg0.conf

COPY ./start-wireguard.sh /start-wireguard.sh

EXPOSE 51820/udp

CMD [ "/start-wireguard.sh" ]
