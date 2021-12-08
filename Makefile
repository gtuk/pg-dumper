.PHONY: help docker-build docker-push

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

docker-build: ## Build all docker images
	docker login
	@echo "Building image for postgres-11.14"
	docker build --no-cache --build-arg PG_VERSION=11.14 -t gtuk/pg-dumper:postgres-11.14 .
	@echo "Building image for postgres-12.9"
	docker build --no-cache --build-arg PG_VERSION=12.9 -t gtuk/pg-dumper:postgres-12.9 .
	@echo "Building image for postgres-13.5"
	docker build --no-cache --build-arg PG_VERSION=13.5 -t gtuk/pg-dumper:postgres-13.5 .
	@echo "Building image for postgres-14.1"
	docker build --no-cache --build-arg PG_VERSION=14.1 -t gtuk/pg-dumper:postgres-14.1 .

docker-publish: docker-build ## Publish all docker images
	@echo "Pushing image gtuk/pg-dumper/postgres-11.14"
	docker push gtuk/pg-dumper:postgres-11.14
	@echo "Pushing image gtuk/pg-dumper/postgres-12.9"
	docker push gtuk/pg-dumper:postgres-12.9
	@echo "Pushing image gtuk/pg-dumper/postgres-13.5"
	docker push gtuk/pg-dumper:postgres-13.5
	@echo "Pushing image gtuk/pg-dumper/postgres-14.1"
	docker push gtuk/pg-dumper:postgres-14.1
