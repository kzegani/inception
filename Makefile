COMPOSE = docker-compose -f ./srcs/docker-compose.yml

all: build-main upd-main

build-main:
	$(COMPOSE) build nginx mariadb wordpress

upd-main:
	$(COMPOSE) up -d nginx mariadb wordpress

bonus: build-bonus upd-bonus

build-bonus:
	$(COMPOSE) build html adminer cadvisor ftp redis

upd-bonus:
	$(COMPOSE) up -d html adminer cadvisor ftp redis

logs:
	$(COMPOSE) logs

clean: down
	docker image prune

fclean: down
	docker rmi wordpress nginx mariadb
	docker volume rm mariadb_volume wordpress_volume
	docker volume prune
	rm -rf /home/kzegani/data/wordpress/*

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

clean-images:
	docker system prune -a -f

clean-hard:
	docker stop $$(docker ps -a -q)
	docker rm $$(docker ps -a -q)
	docker rmi $$(docker images -a -q)
	docker volume prune
	docker network prune
	docker system prune --all --volumes

clean-42:
	docker stop $$(docker ps -qa)
	docker rm $$(docker ps -a -q)
	docker rmi -f $$(docker images -qa)
	docker volume rm $$(docker volume ls -q)
	docker network rm $$(docker network ls -q) 2>/dev/null

re: fclean all

run: all bonus

.PHONY: all build up fclean down stop start clean-images
