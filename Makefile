name = inception

ENV = --env-file ./srcs/.env
COMPOSE = docker-compose -f ./srcs/docker-compose.yml
MAKEDIR = ./srcs/requirements/wordpress/tools/make_dir.sh
VOLUMES = ~/data

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

$(name):
	@bash $(MAKEDIR)
	$(COMPOSE) $(ENV) up --build -d
	@printf "$(GREEN)Succesful launch ${name}\n$(RESET)"

# --build: rebuilds the Docker images before starting the container
# ensures that any changes made are incorporated into the images before starting
build:
	@bash $(MAKEDIR)
	$(COMPOSE) $(ENV) --build
	@printf "$(GREEN)Successful configuration building ${name}\n$(RESET)"

down:
	$(COMPOSE) $(ENV) down
	@printf "$(GREEN)Succesful configuration stopping ${name}\n$(RESET)"

re: down
	$(COMPOSE) $(ENV) up --build -d
	@printf "$(GREEN)Succesful configuration rebuild ${name}\n$(RESET)"

clean: down
	$(COMPOSE) $(ENV) --volumes --rmi all
	@printf "$(GREEN)Succesful configuration cleaning ${name}\n$(RESET)"

fclean:
	@sudo rm -rf $(VOLUMES)
	$(COMPOSE) $(ENV) down --volumes --rmi all
	@printf "$(GREEN)Succesful total clean of all configurations docker\n$(RESET)"

ps:
	$(COMPOSE) ps

.PHONY	: all build down re clean fclean ps
