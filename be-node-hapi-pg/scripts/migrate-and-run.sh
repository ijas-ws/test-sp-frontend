#!/bin/sh
set -a . ".env$ENVIRONMENT_NAME" set +a
# create the db for local builds
sleep 30
if [ "$ENVIRONMENT_NAME" == "local" ]
then
    npx sequelize db:drop
    npx sequelize db:create
fi

# run migrations
npx sequelize db:migrate

# seed data for local builds
if [ "$ENVIRONMENT_NAME" == "local" ]
then
    for file in seeders/*
    do
        :
        ./node_modules/.bin/sequelize db:seed --seed $file
    done
fi

yarn start