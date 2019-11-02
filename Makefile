
CLUSTER=$(if ${ENV},${ENV},dev)
version=$(shell git rev-parse --short HEAD)
APP=${CLUSTER}-srebbyca
tag:
	docker tag node-webapp:$(version) node-webapp:latest

build:
	docker build -t node-webapp:$(version) .

run-prod: stop-prod cleanup
	docker run -d -e "ENV=PROD" -e "PORT=8000" -p 8000:8000 --name=$(APP) node-webapp:$(version)

run-dev: stop cleanup
	docker run -d -e "ENV=DEV" -e "PORT=7000" -p 7000:7000 --name=$(APP) node-webapp:$(version)

run-dr: stop cleanup
	docker run -d -e "ENV=DR" -e "PORT=7002" -p 7002:7002 --name=$(APP) node-webapp:$(version)

run-test: stop cleanup
	docker run -d -e "ENV=TEST" -e "PORT=7001" -p 7001:7001 --name=$(APP) node-webapp:$(version)

stop-all:
	docker stop `sudo docker ps -q`
stop:
	docker stop $(APP)
cleanup:
	docker rm -f $(APP)

all: build tag run-$(CLUSTER)





