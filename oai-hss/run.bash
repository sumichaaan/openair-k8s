#!/bin/bash
# docker run -it \
# 	--privileged \
# 	-d \
# 	-v $(pwd)/config:/config \
# 	-v /dev:/dev \
# 	-v /proc:/proc \
# 	-p 2152:2152/udp \
# 	-p 22100:22100 \
# 	-p 36412:36412/udp \
# 	-p 36422:36422/udp \
# 	-p 50000:50000/udp \
# 	-p 50001:50001/udp \
# 	local/oaienb-usrp:v1.0.3 /bin/sleep 300000

export CASSANDRA_IP=172.17.0.2
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
	oai-hss-20200331r5:latest
