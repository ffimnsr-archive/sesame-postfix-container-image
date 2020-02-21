FROM alpine:3.11

ARG DOMAIN=localdomain
ARG HOSTNAME=localhost.localdomain
ARG HEADER_SIZE_LIMIT=51200
ARG MESSAGE_SIZE_LIMIT=50000000
ARG RELAYNETS
ARG RELAYHOST
ARG SUBNET
ARG RECIPIENT_DELIMITER=+
ARG DELIVERY_USER=postman
ARG DELIVERY_PASSWORD=postman

ENV DOMAIN=${DOMAIN}
ENV HOSTNAME=${HOSTNAME}
ENV HEADER_SIZE_LIMIT=${HEADER_SIZE_LIMIT}
ENV MESSAGE_SIZE_LIMIT=${MESSAGE_SIZE_LIMIT}
ENV RELAYNETS=${RELAYNETS}
ENV RELAYHOST=${RELAYHOST}
ENV SUBNET=${SUBNET}
ENV RECIPIENT_DELIMITER=${RECIPIENT_DELIMITER}
ENV DELIVERY_USER=${DELIVERY_USER}
ENV DELIVERY_PASSWORD=${DELIVERY_PASSWORD}

RUN apk add --no-cache bash postfix postfix-pcre \
    cyrus-sasl cyrus-sasl-plain cyrus-sasl-login cyrus-sasl-crammd5 \
    busybox-extras

COPY postfix /conf
COPY sasl2 /etc/sasl2
COPY restate.sh /
COPY start.sh /

RUN bash /restate.sh

VOLUME ["/queue"]

EXPOSE 25/tcp 10025/tcp

HEALTHCHECK --interval=60s --timeout=30s --start-period=60s --retries=3 CMD echo QUIT | nc localhost 25 | grep "220 .* ESMTP"

CMD ["bash", "/start.sh"]