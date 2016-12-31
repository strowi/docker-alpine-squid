NAME = docker.netfed.local/squid
VERSIONS =

.PHONY: allg versions latest

versions:
	for TAG in $(VERSIONS); do \
		echo "Building $$TAG" ; \
		docker build -t $(NAME):$$TAG --rm --no-cache  -f Dockerfile.$$TAG . ; \
	done

latest:
	docker build -t $(NAME):latest --rm --no-cache  .

all: latest versions
