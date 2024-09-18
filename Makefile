ROOT := $(shell pwd)
export VERSION := $(shell node -p "require('./package.json').version")

export NPM_TOKEN := $(shell node -p "require('./docker-build.json').npmToken")
REPOSITORY := $(shell node -p "require('./docker-build.json').repository")
REPOSITORY_PROD := $(shell node -p "require('./docker-build.json').repositoryProd")

.PHONY: test
test:
	@echo "\nRunning integration tests..."
	@mocha tests/api/init --exit
	@mocha tests/api/users tests/api/auth tests/api/account tests/api/accessKeys tests/api/apps tests/api/index --exit --recursive --timeout 30000

.PHONY: coverage
coverage:
	@echo "\nCheck test coverage..."
	@mocha tests/api/init --exit
	@nyc mocha tests/api/users tests/api/auth tests/api/account tests/api/accessKeys tests/api/apps tests/api/index --exit --recursive --timeout 30000

.PHONY: release-docker
release-docker:
	@echo "\nBuilding docker image..."
	docker pull node:lts-alpine
	docker build --platform="linux/amd64" --build-arg NPM_TOKEN --build-arg VERSION -t ${REPOSITORY}:${VERSION} -t ${REPOSITORY_PROD}:${VERSION} --no-cache .
	docker push ${REPOSITORY}:${VERSION}
	docker push ${REPOSITORY_PROD}:${VERSION}
