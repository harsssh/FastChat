COMPOSE := docker compose
COMPOSE_FILE := docker/compose.yaml
ENV_FILE := docker/.env

up:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d --build

down:
	$(COMPOSE) -f $(COMPOSE_FILE) down

logs:
	$(COMPOSE) -f $(COMPOSE_FILE) logs -f
