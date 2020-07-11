# -*- Makefile -*-

ANSIBLE_VERSION := 2.9.10

# Let's publish the image here.
IMAGE := ludwig/docker-ansible
IMAGE_TAG := $(IMAGE):$(ANSIBLE_VERSION)

# Options: auto, plain, or tty
PROGRESS := plain

build:
	DOCKER_BUILDKIT=1 BUILDKIT_PROGRESS=$(PROGRESS) docker build -t $(IMAGE_TAG) --build-arg ANSIBLE_VERSION=$(ANSIBLE_VERSION) .

publish:
	docker push $(IMAGE_TAG)

publish-latest:
	docker tag $(IMAGE_TAG) $(IMAGE):latest
	docker push $(IMAGE):latest
