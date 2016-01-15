# docker-cassandra

docker build -t "cassandra-single" .

docker run -t "cassandra-single"


## ssh to container for running opecenter

docker exec -ti CONTAINER_ID bash

service datastax-agent start

service opscenterd start
