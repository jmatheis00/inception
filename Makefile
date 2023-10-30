name = inception

# ************************************** #
#   COLORS                               #
# ************************************** #
RED			=	\e[91;118m
GREEN		=	\e[92;118m
YELLOW		=	\e[93;226m
RESET		=	\e[0m

# ************************************** #
#   RULES                                #
# ************************************** #

all:
	@printf "$(GREEN)Launch configuration ${name}...\n$(RESET)"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d
	@printf "$(GREEN)Succesfull launch ${name}\n$(RESET)"
# @bash srcs/requirements/wordpress/tools/make_dir.sh

# --build: rebuilds the Docker images before starting the container
# ensures that any changes made are incorporated into the images before starting
build:
	@printf "$(GREEN)Building configuration ${name}...\n$(RESET)"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
	@printf "$(GREEN)Successfull configuration building ${name}\n$(RESET)"
# @bash srcs/requirements/wordpress/tools/make_dir.sh

down:
	@printf "$(YELLOW)Stopping configuration ${name}...\n$(RESET)"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down
	@printf "$(GREEN)Succesfull configuration stopping ${name}\n$(RESET)"

re: down
	@printf "$(GREEN)Rebuild configuration ${name}...\n$(RESET)"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
	@printf "$(GREEN)Succesfull configuration rebuild ${name}\n$(RESET)"

clean: down
	@printf "$(YELLOW)Cleaning configuration ${name}...\n$(RESET)"
	@docker system prune --all
	@printf "$(GREEN)Succesfull configuration cleaning ${name}\n$(RESET)"

fclean:
	@printf "$(YELLOW)Total clean of all configurations docker\n$(RESET)"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down
	@docker system prune --all
	@docker network prune --force
	@docker volume prune --force
	@docker volume create wp-volume
	@docker volume create db-volume
	@printf "$(GREEN)Succesfull total clean of all configurations docker\n$(RESET)"

kill: fclean
	@printf "$(RED)Total clean, including wordpress configurations\n$(RESET)"
	@sudo rm -rf ~/data
	@printf "$(RED)Succesfull total clean, including wordpress configurations\n$(RESET)"

.PHONY	: all build down re clean fclean
