FROM debian:11
RUN apt-get update \
	&& apt-get install -y nginx \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

COPY /requirements/nginx/tools/jmatheis.42.fr.crt /etc/nginx/ssl/
COPY /requirements/nginx/tools/jmatheis.42.fr.key /etc/nginx/ssl/

# Copy Nginx configuration file
COPY requirements/nginx/conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]