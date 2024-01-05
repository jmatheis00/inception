FROM debian:11

RUN apt-get update && apt-get -y install \
		mariadb-client \
		curl \
		php \
		php-cgi \
		php-fpm \
		php-mysql \
	&& rm -rf /var/lib/apt/lists/*

# install wordpress cli & put it in /usr/local/bin
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp-cli

# Create the directory for runtime data (PHP-related)
RUN mkdir /run/php

COPY requirements/wordpress/conf/create_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wp.sh

# Copy the .conf for PHP-FPM
COPY requirements/wordpress/conf/www.conf /etc/php/7.4/fpm/pool.d/

#main executable for the container
ENTRYPOINT ["/usr/local/bin/create_wp.sh"]

# provides arguments for "exec "$@""
# processes PHP code, returns result to web server
CMD ["/usr/sbin/php-fpm7.4", "-F"]