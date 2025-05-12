#!/bin/bash

docker stop prove-it_devcontainer-mongodb-1
docker stop prove-it_devcontainer-postgres-1
docker stop prove-it_devcontainer-redis-1
docker stop prove-it_devcontainer-kafka-1
docker stop prove-it_devcontainer-zookeeper-1
docker stop prove-it_devcontainer-rabbitmq-1
docker stop prove-it_devcontainer-localstack-1