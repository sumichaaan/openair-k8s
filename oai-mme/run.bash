#!/bin/bash
export DEFAULT_HOST_INTERFACE_NAME=$(ip route get 1.1.1.1 | grep -oP 'dev \K\S+')
export DEFAULT_HOST_INTERFACE_IP=$(ip route get 1.1.1.1 | grep -oP 'src \K\S+')
export HSS_IP="172.17.0.3"
docker run \
        --privileged \
        -d \
        -e MME_SERVICE="mme.openair4G.eur" \
        -e MME_REALM="openair4G.eur" \
        -e MME_GID="4" \
        -e MME_CODE="1" \
        -e MCC="208" \
        -e MNC="92" \
        -e TAC="1" \
        -e MME_CIDR_S1C="${DEFAULT_HOST_INTERFACE_IP}/32" \
        -e MME_CIDR_S11="${DEFAULT_HOST_INTERFACE_IP}/32" \
        -e MME_CIDR_S10="${DEFAULT_HOST_INTERFACE_IP}/32" \
        -e NW_IF_S1C="${DEFAULT_HOST_INTERFACE_NAME}" \
        -e NW_IF_S11="${DEFAULT_HOST_INTERFACE_NAME}" \
        -e NW_IF_S10="${DEFAULT_HOST_INTERFACE_NAME}" \
        -e SGW_CIDR_S11="127.0.0.1/32" \
        -e HSS_SERVICE="hss.openair4G.eur" \
        -e HSS_IP="${HSS_IP}" \
        -e HSS_REALM="openair4G.eur" \
        -e HSS_HOSTNAME="hss" \
        -p 3870:3870 \
        -p 5870:5870 \
        -p 2123:2123 \
        -p 36412:36412 \
        -v $(pwd)/manifests/oai-mme/certs:/opt/oai-mme/certs:Z \
        -h mme.openair4G.eur \
        oai-mme-20200331r1:latest
