start:
	docker-compose up -d

stop:
	docker-compose down

build:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build main.go

zip:
	zip myFunction.zip main

deploy:
	awslocal lambda create-function --function-name myFunction \
    --runtime go1.x --handler main \
    --role arn:aws:iam::123456789012:role/service-role/my-lambda-role \
    --zip-file fileb://myFunction.zip

deployhot:
	awslocal lambda create-function --function-name myFunction \
        --code S3Bucket="hot-reload",S3Key="/mnt/c/Users/Jennie/OneDrive/Documents/GitHub/atkinsonbg/golang-lambda-localstack-hot-reload" \
        --runtime go1.x --handler main \
        --role arn:aws:iam::123456789012:role/service-role/my-lambda-role

update:
	awslocal lambda update-function-code --function-name myFunction \
        --zip-file fileb://myFunction.zip

invoke:
	awslocal lambda invoke \
                 --function-name myFunction \
                 --payload '{ "name": "Bill" }' \
                 /dev/stdout

delete:
	awslocal lambda delete-function \
            --function-name myFunction

list:
	awslocal lambda list-functions