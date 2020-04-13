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

docker run -it \
	--privileged \
	-d \
	-v $(pwd)/../configs:/config \
	-v /dev:/dev \
	-v /lib/modules:/lib/modules:ro \
        --net=host \
	oai-enb-20200325b1:latest
	# oai-enb-20200324r4:latest /bin/sleep 300000

# EXPOSE 2152/udp
# EXPOSE 22100/tcp
# EXPOSE 36412/udp
# EXPOSE 36422/udp
# EXPOSE 50000/udp
# EXPOSE 50001/udp


