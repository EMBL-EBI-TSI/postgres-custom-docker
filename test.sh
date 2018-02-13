#!/bin/bash
set -e

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
PG_DB_NAME=builddb

# Start the container
docker build -t $DOCKER_IMAGE .
DOCKER_INSTANCE=$(docker run -d --rm -p $PG_PORT:5432 -e POSTGRES_USER=$PG_USER -e POSTGRES_PASSWORD=$PG_PWD -e POSTGRES_DB=$PG_DB_NAME $DOCKER_IMAGE)
echo Started $DOCKER_INSTANCE

# wait until we know whether the things inside are alive/dead
until docker inspect --format "{{index .State.Health.Status}}" $DOCKER_INSTANCE | grep -q healthy; do echo -n "."; sleep 1; done
DOCKER_STATE=$(docker inspect --format "{{index .State.Health.Status}}" $DOCKER_INSTANCE)
echo
echo "State $DOCKER_STATE"
if [ "$DOCKER_STATE" = "unhealthy" ]; then exit 1; fi

# now perform the test
echo Starting tests
PGPASSWORD=$PG_PWD psql -h localhost -p $PG_PORT -U $PG_USER $PG_DB_NAME -c 'select count(*) from pg_stat_activity;'
