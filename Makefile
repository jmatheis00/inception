name = inception

ENV = --env-file ./srcs/.env
COMPOSE = docker-compose -f ./srcs/docker-compose.yml
# MAKEDIR = ./srcs/requirements/wordpress/tools/make_dir.sh
VOLUMES = /home/${USER}/data
VOLUME_WP = $(VOLUMES)/wordpress
VOLUME_DB = $(VOLUMES)/mariadb

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

all: $(name)

$(name): makedirs
	$(COMPOSE) $(ENV) up --build -d
	@printf "$(GREEN)Succesful launch ${name}\n$(RESET)"

# --build: rebuilds the Docker images before starting the container
# ensures that any changes made are incorporated into the images before starting

build: makedirs
	$(COMPOSE) $(ENV) --build
	@printf "$(GREEN)Successful building ${name}\n$(RESET)"

makedirs:
	mkdir -p $(VOLUME_DB) $(VOLUME_WP)

stop:
	$(COMPOSE) $(ENV) stop
	@printf "$(GREEN)Successful building ${name}\n$(RESET)"

down:
	$(COMPOSE) $(ENV) down
	@printf "$(GREEN)Succesful stopping ${name}\n$(RESET)"

re: fclean $(name)
	@printf "$(GREEN)Succesful rebuild ${name}\n$(RESET)"

clean:
	$(COMPOSE) $(ENV) down --volumes --rmi all
	@printf "$(GREEN)Succesful cleaning ${name}\n$(RESET)"

fclean: clean
	@sudo rm -rf $(VOLUMES)
	@printf "$(GREEN)Succesful total clean of all configurations docker\n$(RESET)"

ps:
	$(COMPOSE) ps

.PHONY	: all build down re clean fclean ps
