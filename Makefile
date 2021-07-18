.PHONY: build
build: ## Build Docker Image.
	docker-compose up -d
# docker network create schemaspy_practiceが事前に必要

.PHONY: stop
stop: ## stop Docker container.
	docker ps -aq --filter "name=hirokita_test_db" | xargs docker stop

.PHONY: remove
remove: ## remove Docker container.
	docker ps -aq --filter "name=hirokita_test_db" | xargs docker rm

.PHONY: push
push: ## Modifies the schemas on database
	docker run --rm --net=schemaspy_practice -v $(CURDIR):/skeema schemaspy_practice_skeema:latest skeema push development --allow-unsafe

.PHONY: schemaspy
schemaspy: ## create ER images by schemaspy
	docker run --rm --net="host" -v $(PWD)/schemaspy/output:/output \
	-v $(PWD)/schemaspy/schemaspy.properties:/schemaspy.properties schemaspy/schemaspy:snapshot \
	-t mysql -host 127.0.0.1:3306 -db hirokita_test -u root -p XXXX -connprops useSSL\\\\=false -s hirokita_test

