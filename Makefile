start:
	docker-compose up -d

stop:
	docker-compose down

build:
	go build -o go-lambda