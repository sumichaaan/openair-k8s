#!/bin/bash

export CASSANDRA_IP=192.168.56.10
docker run \
        --privileged \
        -d \
        -e DB_FQDN=${CASSANDRA_IP} \
        -e DB_NAME=vhss \
        -e DB_USER=cassandra \
        -e DB_PASSWORD=cassandra \
        -e OP_KEY="11111111111111111111111111111111" \
        -e HSS_FQDN="hss.openair4G.eur" \
        -e ROAMING_ALLOWED="true" \
        -p 3868:3868 \
        -p 5868:5868 \
        -p 9080:9080 \
        -p 9081:9081 \
        -v $(pwd)/certs:/opt/oai-hss/certs \
        -h hss.openair4G.eur \
        --net=oai_network \
        --ip=192.168.56.11 \
        oai-hss-20200401r1:ubt18
