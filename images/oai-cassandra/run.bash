#!/bin/bash

docker run -it \
	--privileged \
	-d \
	-e CASSANDRA_DC=DC1 \
        -e CASSANDRA_RACK=RACK1 \
        -e CASSANDRA_CLUSTER_NAME=OAI_HSS \
        -e CASSANDRA_ENDPOINT_SNITCH="GossipingPropertyFileSnitch" \
	-p 9042:9042 \
	cassandra:3.11
