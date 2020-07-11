# -*- Makefile -*-

# Let's publish the image here.
IMAGE_TAG := ludwig/docker-ansible

# Options: auto, plain, or tty
PROGRESS := plain

build:
	DOCKER_BUILDKIT=1 BUILDKIT_PROGRESS=$(PROGRESS) docker build -t $(IMAGE_TAG) .

push:
	docker push $(IMAGE_TAG)
