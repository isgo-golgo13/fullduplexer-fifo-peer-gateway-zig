# Variables
APP_NAME := full_duplexer_zig
DOCKER_COMPOSE_FILE := docker-compose.yml

# Build the Zig app
.PHONY: build
build:
	zig build

# Build the Docker images
.PHONY: build-images
build-images:
	docker build -f Dockerfile.peer -t $(APP_NAME)_peer .
	docker build -f Dockerfile.peer.gateway -t $(APP_NAME)_gateway .

# Bring up Docker Compose
.PHONY: up
up:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

# Bring down Docker Compose
.PHONY: down
down:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

# Clean build
.PHONY: clean
clean:
	rm -rf zig-out
	docker-compose -f $(DOCKER_COMPOSE_FILE) down
	docker-compose rm -f
