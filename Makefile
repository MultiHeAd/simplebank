postgres:
	docker run --name postgres12 --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	winpty docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	winpty docker exec -it postgres12 dropdb simple_bank

make migrateup:
	migrate -path db/migration -database "postgresql://root:pc%3Cf%3FwGXYx.t6ZVVb6V~E~6Q%3C4f%28@simple-bank.crauaqceuo2j.us-east-1.rds.amazonaws.com:5432/simple_bank" -verbose up

migrateup1:
	 migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	 migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedown1:
	 migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/techschool/simplebank/db/sqlc Store


.PHONY:postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server mock