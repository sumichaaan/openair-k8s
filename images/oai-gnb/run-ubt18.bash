docker run -it \
        --privileged \
        -ti \
        -v /dev:/dev \
        -v /lib/modules:/lib/modules:ro \
	-v $(pwd)/conf:/conf \
	-e GNB_ID="0x0e00" \
	-e GNB_NAME="gNB-Eurecom-5GNRBox" \
	-e MCC="208" \
	-e MNC="93" \
	-e TAC="1" \
	-e MME_IP4="192.168.1.100" \
	-e MME_IP6="192:168:" \
	-e S1_MME_IF="net1" \
	-e S1_MME_IP="192.168.1.123" \
	-e S1_U_IF="net2" \
	-e S1_U_IP="172.16.2.123" \
	--net=host \
	--entrypoint bash \
        localhost/ooladmin/oai-gnb:ubt18
