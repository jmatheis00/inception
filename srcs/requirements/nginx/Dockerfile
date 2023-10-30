FROM debian:11
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y nginx \
	&& apt-get install -y openssl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Docker container listens on port 443 (HTTPS traffic)
# COPY ./conf/nginx.conf /etc/nginx/http.d/
# COPY index.html /usr/share/nginx/html

COPY ./index.html /usr/share/nginx/html/index.html
WORKDIR /usr/share/nginx/html
RUN date +%x_%H:%M:%S:%N >> ./index.html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]