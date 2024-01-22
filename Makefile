VERSION = 2.49.1
SERVICE = prometheus-docker-armv6
DOCKER_IMAGE_TAG = latest
OWNER = oppermax
PROMETHEUS_VERSION := v2.49.1
PROMETHEUS_TAR_FILE := prometheus-$(PROMETHEUS_VERSION).freebsd-armv6.tar.gz

.PHONY: fetch-release
fetch-release:
	@echo "Fetching release $(VERSION)"
	curl -LO -H "Accept: application/octet-stream" https://github.com/prometheus/prometheus/releases/download/v$(VERSION)/prometheus-$(VERSION).freebsd-armv6.tar.gz; \
	tar -xzvf prometheus-$(VERSION).freebsd-armv6.tar.gz

.PHONY: docker-build
docker-build: fetch-release
	@echo "Building image"
	@cp Dockerfile prometheus-$(VERSION).freebsd-armv6/
	@cp prometheus.yml prometheus-$(VERSION).freebsd-armv6/
	@docker buildx build -t $(OWNER)/$(SERVICE):$(DOCKER_IMAGE_TAG) --platform linux/arm/v6 prometheus-$(VERSION).freebsd-armv6

.PHONY: docker-push
docker-push: docker-build
	docker push $(OWNER)/$(SERVICE):$(DOCKER_IMAGE_TAG)

.PHONY: clear
clear:
	rm -rf prometheus-$(VERSION).freebsd-armv6
	rm -rf prometheus-$(VERSION).freebsd-armv6.tar.gz
