docker run -it \
        --privileged \
        -ti \
        -d \
        -v $(pwd)/../configs:/config \
        -v /dev:/dev \
        -v /lib/modules:/lib/modules:ro \
        --net=oai_network \
        --ip=192.168.56.100 \
        oai-enb-20200403r1:ubt18
