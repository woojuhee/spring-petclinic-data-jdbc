.PYONY: help

DOCKER_IMAGE_NAME ?= spring-petclinic-data-jdbc
DOCKER_PROJECT_NAME ?= docker.io/jheewoo
DOCKER_IMAGE_VERSION ?= $(shell git describe)
DOCKER_REPOSITORY ?= $(DOCKER_PROJECT_NAME)/$(DOCKER_IMAGE_NAME)
GIT_BRANCH ?= master

help: ## show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

check-git-clean: ## Check git
	@if [ -z "`git status --porcelain .`" ]; \
		then \
		echo "Working directory is clean"; \
		else \
		echo "Working directory is not clean. "; exit 1; \
	fi

build: ## Build image
	@docker build -t $(DOCKER_REPOSITORY):latest .
	@docker tag $(DOCKER_REPOSITORY):latest $(DOCKER_REPOSITORY):$(DOCKER_IMAGE_VERSION)-maven

push: ## check-git-clean build-image ## Push image
	@docker push $(DOCKER_REPOSITORY):$(DOCKER_IMAGE_VERSION)-maven

build-gradle: ## Build image
	@docker build -t $(DOCKER_REPOSITORY):latest -f ./Dockerfile_gradle .
	@docker tag $(DOCKER_REPOSITORY):latest $(DOCKER_REPOSITORY):$(DOCKER_IMAGE_VERSION)-gradle

push-gradle: ## check-git-clean build-image ## Push image
	@docker push $(DOCKER_REPOSITORY):$(DOCKER_IMAGE_VERSION)-gradle

sonarqube:
	@docker build \
		--build-arg GIT_BRANCH=$(GIT_BRANCH) \
		-f Dockerfile-sonar \
		-t $(DOCKER_REPOSITORY):sonarqube .
	@docker rmi $(DOCKER_REPOSITORY):sonarqube
