#!/bin/sh

echo "DB_SOURCE: $DB_SOURCE"
echo "run db migration"
source /app/app.env
/app/migrate -path ./migration -database "$DB_SOURCE" -verbose up

echo "start the app"
exec "$@"
