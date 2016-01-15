# docker-cassandra

docker build -t "cassandra-single" .

docker run -t "cassandra-single"


## ssh to container for running opecenter
#docker exec -ti <CONTAINER ID> bash


docker exec -it 0fd6cbe3767d bash



service datastax-agent start
service opscenterd start