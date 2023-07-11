# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vfuhlenb <vfuhlenb@student.42wolfsburg.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/06 08:33:18 by vfuhlenb          #+#    #+#              #
#    Updated: 2023/07/06 08:34:03 by vfuhlenb         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include srcs/.env

.PHONY: re all build stop up down clean fclean clean-data

all: build up
re: clean all
build:
	bash srcs/requirements/mariadb/tools/create_folders.sh
	docker compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) build
stop:
	docker compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) stop
up:
	docker compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) up -d
down:
	docker compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) down
clean:
	docker compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) down -v --remove-orphans
	docker rmi -f nginx
	docker rmi -f mariadb
	docker rmi -f wordpress
fclean: clean
	docker system prune -a --force
	sudo rm -rf ~/data
clean-data:
	sudo rm -rf ~/data