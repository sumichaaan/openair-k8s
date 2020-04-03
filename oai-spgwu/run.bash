#!/bin/bash
docker run \
	--privileged \
	-d \
        -e SGW_S1U_INTERFACE="eth0" \
        -e SGW_SX_INTERFACE="eth0" \
        -e PGW_SGI_INTERFACE="eth0" \
        -e NETWORK_UE_IP="192.168.20.0/24" \
        -e PGWC_SX_IP_ADDRESS="192.168.56.13" \
	-e PGWU_SGI_GW="192.168.56.1" \
        -p 8805:8805 \
	-p 2123:2123 \
        -h spgwu.openair4G.eur \
	--net=oai_network \
	--ip=192.168.56.14 \
	oai-spgwu-20200403r1:ubt18
