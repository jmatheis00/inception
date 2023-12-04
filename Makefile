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

all: $(NAME)

$(NAME):
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up --build -d
	@printf "$(GREEN)Succesful launch ${name}\n$(RESET)"

# --build: rebuilds the Docker images before starting the container
# ensures that any changes made are incorporated into the images before starting
build:
	@printf "$(GREEN)Building configuration ${name}...\n$(RESET)"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
	@printf "$(GREEN)Successful configuration building ${name}\n$(RESET)"

down:
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down
	@printf "$(GREEN)Succesful configuration stopping ${name}\n$(RESET)"

re: down
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
	@printf "$(GREEN)Succesful configuration rebuild ${name}\n$(RESET)"

clean:
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down --volumes -rmi all
	@printf "$(GREEN)Succesful configuration cleaning ${name}\n$(RESET)"

fclean:
	@sudo rm -rf ~/data
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down --volumes -rmi all
	@printf "$(GREEN)Succesful total clean of all configurations docker\n$(RESET)"

.PHONY	: all build down re clean fclean
