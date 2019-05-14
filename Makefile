SHELL:=/bin/bash
UNAME_S := $(shell uname -s)

git_branch_name = $(shell git rev-parse --abbrev-ref HEAD)
git_tag_name = $(shell git describe --tags --abbrev=0)
git_commit_sha = $(shell git rev-parse --short HEAD)

server_name = istio-playground
image_tag = chechiachang/$(server_name)
image_version = $(git_branch_name)-$(git_commit_sha)
image_name = $(image_tag):$(image_version)

run:
	go run cmd/server/main.go

.PHONY: cmd

cmd:
	#go build -o build/bin/entrypoint cmd/server/main.go
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/bin/entrypoint cmd/server/main.go

build: cmd
	docker build -t $(image_name) --file build/Dockerfile .

push:
	docker push $(image_name)

ifeq ($(UNAME_S),Linux)
tag:
	sed -i 's|image:.*|image: $(image_name)|g' deploy/deployment.yaml
endif
ifeq ($(UNAME_S),Darwin)
tag:
	sed -i "" 's|image:.*|image: $(image_name)|g' deploy/deployment.yaml
endif
