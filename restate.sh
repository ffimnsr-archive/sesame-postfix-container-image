#!/usr/bin/env bash

set -e

function __updatePostfixConf {
    cp -r /conf/* /etc/postfix/

    for VARIABLE in `env | cut -f1 -d=`; do
        VAR=${VARIABLE//:/_}
        sed -i "s={{ $VAR }}=${!VAR}=g" /etc/postfix/*.cf
    done

    postmap /etc/postfix/virtual_*
}

function __createSaslDeliveryUser {
    echo -n $DELIVERY_PASSWORD | saslpasswd2 -p -c -u `postconf -h mydomain` $DELIVERY_USER
    chown -R postfix: /etc/sasl2
}

__updatePostfixConf
__createSaslDeliveryUser
