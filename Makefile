
CLUSTER=$(if ${ENV},${ENV},dev)
version=$(shell git rev-parse --short HEAD)
APP=${CLUSTER}-srebbyca
IMAGE=542068092988.dkr.ecr.us-east-2.amazonaws.com/srebbyca/nodejs-app:latest

run-prod:
	docker run -d -e "ENV=PROD" -e "PORT=8000" -p 8000:8000 --name=$(APP) $(IMAGE)

run-dev: 
	docker run -d -e "ENV=DEV" -e "PORT=7000" -p 7000:7000 --name=$(APP) $(IMAGE)

run-dr: 
	docker run -d -e "ENV=DR" -e "PORT=7002" -p 7002:7002 --name=$(APP) $(IMAGE)

run-test: 
	docker run -d -e "ENV=TEST" -e "PORT=7001" -p 7001:7001 --name=$(APP) $(IMAGE)

stop-all:
	docker stop `sudo docker ps -q`
stop:
	docker stop $(APP)
cleanup:
	docker rm -f $(APP)

release: run-$(CLUSTER)

finish: stop cleanup





