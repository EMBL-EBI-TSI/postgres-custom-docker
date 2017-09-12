#!/bin/bash

function finally {
  if [ -n "$DOCKER_INSTANCE" ]
  then
    echo Stopping $DOCKER_INSTANCE
    docker stop $DOCKER_INSTANCE
  fi
}

trap finally EXIT

DOCKER_IMAGE=postgres-custom-ci
PG_PORT=5438
PG_USER=build
PG_PWD=buildsecret

docker build -t $DOCKER_IMAGE .
DOCKER_INSTANCE=`docker run -d --rm -p $PG_PORT:5432 -e POSTGRES_USER=$PG_USER -e POSTGRES_PASSWORD=$PG_PWD $DOCKER_IMAGE`
echo Started $DOCKER_INSTANCE
sleep 5s
PGPASSWORD=$PG_PWD psql -h localhost -p $PG_PORT -U $PG_USER postgres -c 'select count(*) from pg_stat_activity;'
