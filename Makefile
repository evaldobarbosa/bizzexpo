.PHONY: help clone up down build logs shell-api shell-front artisan composer pnpm test migrate fresh seed renew

# Cores
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)

# Repositórios
API_REPO   := git@github.com:code2-consultoria/bizzexpo-api.git
FRONT_REPO := git@github.com:evaldobarbosa/bizzexpo-front.git

## Ajuda
help: ## Mostra esta ajuda
	@echo ''
	@echo 'Uso:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<comando>${RESET}'
	@echo ''
	@echo 'Comandos:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  ${YELLOW}%-15s${RESET} %s\n", $$1, $$2}' $(MAKEFILE_LIST)

## Clonagem
clone: ## Clona os repositórios api e front
	@echo "${GREEN}Clonando repositórios...${RESET}"
	@if [ ! -d "api" ]; then \
		git clone $(API_REPO) api; \
	else \
		echo "api/ já existe, pulando..."; \
	fi
	@if [ ! -d "front" ]; then \
		git clone $(FRONT_REPO) front; \
	else \
		echo "front/ já existe, pulando..."; \
	fi
	@echo "${GREEN}Repositórios clonados!${RESET}"

clone-https: ## Clona os repositórios via HTTPS
	@echo "${GREEN}Clonando repositórios via HTTPS...${RESET}"
	@if [ ! -d "api" ]; then \
		git clone https://github.com/code2-consultoria/bizzexpo-api.git api; \
	else \
		echo "api/ já existe, pulando..."; \
	fi
	@if [ ! -d "front" ]; then \
		git clone https://github.com/evaldobarbosa/bizzexpo-front.git front; \
	else \
		echo "front/ já existe, pulando..."; \
	fi
	@echo "${GREEN}Repositórios clonados!${RESET}"

## Docker
up: ## Inicia os containers
	docker compose up -d

down: ## Para os containers
	docker compose down

build: ## Reconstrói os containers
	docker compose build --no-cache

logs: ## Mostra logs dos containers
	docker compose logs -f

logs-api: ## Mostra logs da API
	docker compose logs -f api

logs-front: ## Mostra logs do frontend
	docker compose logs -f front

## Shell
shell-api: ## Acessa o shell do container da API
	docker compose exec api bash

shell-front: ## Acessa o shell do container do frontend
	docker compose exec front sh

## Laravel
artisan: ## Executa comando artisan (ex: make artisan cmd="migrate")
	docker compose exec api php artisan $(cmd)

composer: ## Executa comando composer (ex: make composer cmd="require laravel/sanctum")
	docker compose exec api composer $(cmd)

migrate: ## Executa migrations
	docker compose exec api php artisan migrate

fresh: ## Recria o banco de dados
	docker compose exec api php artisan migrate:fresh

seed: ## Executa seeders
	docker compose exec api php artisan db:seed

renew: ## Recria o banco com seeders
	docker compose exec api composer renew

test: ## Executa testes
	docker compose exec api php artisan test

test-filter: ## Executa testes filtrados (ex: make test-filter filter="UserTest")
	docker compose exec api php artisan test --filter=$(filter)

## Frontend
pnpm: ## Executa comando pnpm (ex: make pnpm cmd="add axios")
	docker compose exec front pnpm $(cmd)

## Setup
setup: clone ## Configura o projeto pela primeira vez
	@echo "${GREEN}Configurando projeto...${RESET}"
	cp api/.env.example api/.env
	cp front/.env.example front/.env
	docker compose build
	docker compose up -d
	docker compose exec api composer install
	docker compose exec api php artisan key:generate
	docker compose exec api php artisan migrate
	@echo "${GREEN}Projeto configurado!${RESET}"
	@echo "API: http://localhost:8095"
	@echo "Frontend: http://localhost:5190"
	@echo "Mailpit: http://localhost:8025"

pull: ## Atualiza os repositórios api e front
	@echo "${GREEN}Atualizando repositórios...${RESET}"
	cd api && git pull
	cd front && git pull
	@echo "${GREEN}Repositórios atualizados!${RESET}"
