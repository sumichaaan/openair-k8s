#!/bin/bash
export DEFAULT_HOST_INTERFACE_NAME=$(ip route get 1.1.1.1 | grep -oP 'dev \K\S+')
export DEFAULT_HOST_INTERFACE_IP=$(ip route get 1.1.1.1 | grep -oP 'src \K\S+')
# export HSS_IP=192.168.56.11
export HSS_IP=192.168.31.113
docker run \
        -it \
        --privileged \
        -d \
        -e MME_SERVICE="mme.openair4G.eur" \
        -e MME_REALM="openair4G.eur" \
        -e MME_GID="4" \
        -e MME_CODE="1" \
        -e MCC="208" \
        -e MNC="73" \
        -e TAC="1" \
        -e MME_CIDR_S1C="192.168.56.12/32" \
        -e MME_CIDR_S11="192.168.56.12/32" \
        -e MME_CIDR_S10="127.0.0.1/32" \
        -e NW_IF_S1C="eth0" \
        -e NW_IF_S11="eth0" \
        -e NW_IF_S10="eth0" \
        -e SGW_CIDR_S11="127.0.0.1/32" \
        -e HSS_SERVICE="hss.openair4G.eur" \
        -e HSS_IP="${HSS_IP}" \
        -e HSS_REALM="openair4G.eur" \
        -e HSS_HOSTNAME="hss" \
        -p 3870:3870 \
        -p 5870:5870 \
        -p 2123:2123 \
        -p 36412:36412 \
        -v $(pwd)/certs:/opt/oai-mme/certs:Z \
        -h mme.openair4G.eur \
        --net=oai_network \
        --ip=192.168.56.12 \
        oai-mme-20200401r1:ubt18
