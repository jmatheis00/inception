FROM debian:11
RUN apt-get update \
	&& apt-get install -y nginx \
	&& apt-get install -y openssl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -days 365 -nodes \
	-keyout /etc/nginx/ssl/jmatheis.42.fr.key \
	-out /etc/nginx/ssl/jmatheis.42.fr.crt \
	-subj "/CN=jmatheis.42.fr/O=42Heilbronn/OU=42Student"

# Copy Nginx configuration file
COPY requirements/nginx/conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]