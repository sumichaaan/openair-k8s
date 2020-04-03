 docker run -it \
         --privileged \
        -ti \
         -d \
         -v $(pwd)/../configs:/config \
         -v /dev:/dev \
         -v /lib/modules:/lib/modules:ro \
         --net=host \
         oai-enb-20200403r1:ubt18 \
        /bin/bash

# docker run -it \
#         --privileged \
#       -ti \
#         -d \
#         -v $(pwd)/../configs:/config \
#         -v /dev:/dev \
#         -v /lib/modules:/lib/modules:ro \
#         --net=host \
#         oai-enb-20200325b1 \
#       /bin/bash
