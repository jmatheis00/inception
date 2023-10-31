FROM debian:11
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y nginx \
	&& apt-get install -y openssl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

COPY /requirements/nginx/tools/jmatheis.42.fr.crt /etc/nginx/ssl/
COPY /requirements/nginx/tools/jmatheis.42.fr.key /etc/nginx/ssl/

# Copy Nginx configuration file
COPY requirements/nginx/conf/nginx.conf /etc/nginx/sites-available/jmatheis.42.fr

# Create symbolic link to enable the configuration
RUN ln -s /etc/nginx/sites-available/jmatheis.42.fr /etc/nginx/sites-enabled/
# Remove the default Nginx configuration
RUN rm /etc/nginx/sites-enabled/default

#test
COPY /requirements/nginx/index.html /var/www/html/index.html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]