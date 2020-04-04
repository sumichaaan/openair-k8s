#!/bin/bash

export CS_HOST_IPS=192.168.56.10
export CS_PORT=9042
export CS_USER=cassandra
export CS_PASSWORD=cassandra

docker run -d -p 3000:3000 \
    -e CASSANDRA_HOST_IPS=${CS_HOST_IPS} \
    -e CASSANDRA_PORT=${CS_PORT} \
    -e CASSANDRA_USER=${CS_USER} \
    -e CASSANDRA_PASSWORD=${CS_PASSWORD} \
    markusgulden/cassandra-web:latest
