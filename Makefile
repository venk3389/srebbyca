
CLUSTER=$(if ${ENV},$(shell echo ${ENV} | tr '[:upper:]' '[:lower:]'),dev)
APP=${CLUSTER}-srebbyca
IMAGE=542068092988.dkr.ecr.us-east-2.amazonaws.com/srebbyca/nodejs-app/${ENV}-web-app:latest

run:
	docker run -d -e "ENV=$(ENV)" -e "PORT=$(PORT)" -p $(PORT):$(PORT) --name=$(APP) $(IMAGE)


stop-all:
	docker stop `sudo docker ps -q`
stop:
	docker stop $(APP)
cleanup:
	docker rm -f $(APP)

test: run

release: run

clean: stop cleanup





