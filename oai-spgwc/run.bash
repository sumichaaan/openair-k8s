#!/bin/bash
docker run \
	--privileged \
	-d \
        -e PGW_SX_INTERFACE="eth0" \
	-e SGW_S11_INTERFACE="eth0" \
	-e UE_IP_ADDRESS_POOL="192.168.20.2-192.168.20.200" \
	-e UE_DNS_SERVER="8.8.8.8" \
        -p 8805:8805 \
	-p 2123:2123 \
        -h spgwc.openair4G.eur \
	--net=oai_network \
	--ip=192.168.56.13 \
	oai-spgwc-20200401r1:ubt18
