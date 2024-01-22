VERSION = 2.49.1
SERVICE = prometheus-docker-armv6
DOCKER_IMAGE_TAG = latest
OWNER = oppermax

.PHONY: fetch-release
fetch-release:
	@echo "Fetching release $(VERSION)"
	curl -LO -H "Accept: application/octet-stream" https://github.com/prometheus/prometheus/releases/download/v$(VERSION)/prometheus-$(VERSION).linux-armv6.tar.gz; \
	tar -xzvf prometheus-$(VERSION).linux-armv6.tar.gz

.PHONY: docker-build
docker-build:
	@echo "Building image"
	@cp Dockerfile prometheus-$(VERSION).linux-armv6/
	@docker buildx build -t $(OWNER)/$(SERVICE):$(DOCKER_IMAGE_TAG) --platform linux/arm/v6 prometheus-$(VERSION).linux-armv6

.PHONY: docker-push
docker-push: docker-build
	docker push $(OWNER)/$(SERVICE):$(DOCKER_IMAGE_TAG)

.PHONY: clear
clear:
	rm -rf prometheus-$(VERSION).linux-armv6
	rm -rf prometheus-$(VERSION).linux-armv6.tar.gz
