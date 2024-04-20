all: build upd

build:
	docker-compose -f ./srcs/docker-compose.yml build

upd:
	docker-compose -f ./srcs/docker-compose.yml up -d

up:
	docker-compose -f ./srcs/docker-compose.yml up

clean: down
	docker image prune

fclean: down
	docker rmi wordpress nginx mariadb
	docker volume rm mariadb_volume wordpress_volume

down:
	docker-compose -f ./srcs/docker-compose.yml down

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

start:
	docker-compose -f ./srcs/docker-compose.yml start

clean-images:
	docker system prune -a -f

re: clean all

.PHONY: all build up fclean down stop start clean-images
