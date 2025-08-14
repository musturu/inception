SERVICE_ENV_FILES := ./srcs/mariadb/.env.mariadb ./srcs/wordpress/.env.wordpress
SECRETS_FILES := ./secrets/db_password.txt ./secrets/db_root_password.txt
VOLUME_PATHS := $(HOME)/data/db $(HOME)/data/wp/html

all: envs volumes secrets up

envs:
	$(MAKE) gen_env_mariadb
	$(MAKE) gen_env_wordpress

gen_env_mariadb: secrets
	@echo "# .env.mariadb" > ./srcs/mariadb/.env.mariadb
	@echo "MYSQL_DATABASE=wp_$(USER)" >> ./srcs/mariadb/.env.mariadb
	@echo "MYSQL_USER=$(USER)" >> ./srcs/mariadb/.env.mariadb

gen_env_wordpress: secrets
	@echo "# .env.wordpress" > ./srcs/wordpress/.env.wordpress
	@echo "WORDPRESS_DB_NAME=wp_$(USER)" >> ./srcs/wordpress/.env.wordpress
	@echo "WORDPRESS_DB_USER=$(USER)" >> ./srcs/wordpress/.env.wordpress
	@echo "WORDPRESS_DB_HOST=mariadb" >> ./srcs/wordpress/.env.wordpress


	
volumes:
	@echo "Creating and setting permissions for volume directories..."
	mkdir -p $(VOLUME_PATHS)
	@sudo chown -R 100:101 $(HOME)/data/db
	@sudo chmod -R 777 $(HOME)/data/db
	@sudo chown -R 82:82 $(HOME)/data/wp
	@sudo chmod -R 777 $(HOME)/data/wp
	@echo "Volume directories prepared with correct permissions."

secrets:
	@mkdir -p ./secrets
	@tr -dc 'A-Za-z0-9' </dev/urandom | head -c 32 > ./secrets/db_password.txt
	@tr -dc 'A-Za-z0-9' </dev/urandom | head -c 32 > ./secrets/db_root_password.txt


up:
	docker compose -f ./srcs/docker-compose.yml up --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean:
	rm -f $(SERVICE_ENV_FILES) $(SECRETS_FILES)

fclean: down clean
	@echo "Removing volume directories..."
	@sudo rm -rf $(VOLUME_PATHS)
	@docker system prune -af --volumes


.PHONY: all envs gen_env_mariadb gen_env_wordpress secrets volumes up down clean fclean