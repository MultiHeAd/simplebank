#!/bin/sh

echo "DB_SOURCE: $DB_SOURCE"
echo "run db migration"
/app/migrate -path ./migration -database "$DB_SOURCE" -verbose up

echo "start the app"
exec "$@"
