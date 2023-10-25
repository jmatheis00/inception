FROM debian:11
RUN apt-get update && apt-get upgrade -y \
	&& apt-get install -y nginx && apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Docker container listens on port 443 (HTTPS traffic)
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]