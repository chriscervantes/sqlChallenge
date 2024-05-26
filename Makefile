
.PHONY: run build stop logs

COMPOSE= docker compose
LOGSIZE=200
.MAIN: run

run:
	$(COMPOSE) up -d

build:
	$(COMPOSE) build

stop: 
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f --tail=$(LOGSIZE) server

clean:
	docker volume rm sql-challenge_db-data