# docker-docker-build

## Description

Docker image for build and validate docker images.

## Software Requirements

* `docker`
* `make`
* `shellcheck`
* `hadolint`

## Usage

Please see the [Makefile](./Makefile).

Basically, you need the following:

```bash
make init
make build
make run
```

For exit without finishing container please use `Ctrl+P Ctrl+Q`. In this case you can use `make attach` for attaching to the running container.

Other targets you may use as you need.

## Upload image to Docker Hub

```bash
# Create access token and login into docker from CLI
docker login -u <your username>

# Build image
docker build -t docker-build .

# Tag the image 
docker image tag docker-build borchevkin/docker-build:latest

# Push the image with tag latest
docker image push borchevkin/docker-build:latest

# Push the image with version
docker image push borchevkin/docker-build:1.0.0
```

