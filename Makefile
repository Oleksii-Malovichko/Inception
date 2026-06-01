NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml
# change alex to omalovic
DATA_DIR = /home/alex/data

all: up

# create dirs and launch the project
up:
	mkdir -p $(DATA_DIR)/db
	mkdir -p $(DATA_DIR)/wordpress
	$(COMPOSE) up --build -d

# stop container (without removing data)
down:
	$(COMPOSE) down

# whole cleaning
fclean:
	$(COMPOSE) down -v
	sudo rm -rf $(DATA_DIR)

re: fclean up

# check logs
logs:
	$(COMPOSE) logs -f 

ps:
	$(COMPOSE) ps

mariadb:
	docker exec -it mariadb bash

wordpress:
	docker exec -it wordpress bash

nginx:
	docker exec -it nginx bash