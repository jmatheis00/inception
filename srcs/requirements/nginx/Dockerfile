FROM debian:11
RUN apt-get update \
	&& apt-get install -y nginx \
	&& apt-get install -y openssl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

COPY /requirements/nginx/tools/jmatheis.42.fr.crt /etc/nginx/ssl/
COPY /requirements/nginx/tools/jmatheis.42.fr.key /etc/nginx/ssl/

# RUN openssl req -newkey rsa:2048 \
# 	-keyout /etc/nginx/ssl/jmatheis.42.fr.key -x509 -days 365 -nodes \
# 	-out /etc/nginx/ssl/jmatheis.42.fr.crt \
# 	-subj "/CN=jmatheis.42.fr/O=42Heilbronn/OU=42Student"

# Copy Nginx configuration file
COPY requirements/nginx/conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

# # Certificate
# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -sha256 \
#     -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt \
#     -subj "/C=DE/L=Heilbronn/OU=Student/O=42HN/CN=fbruggem.42.fr"