FROM debian:11

RUN apt-get update && apt-get -y install \
		mariadb-client \
		wget \
		curl \
		bash \
		php \
		php-cgi \
		php-fpm \
		php-mysql \
	&& rm -rf /var/lib/apt/lists/*

# install wordpress cli & put it in /usr/local/bin
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp-cli

# Create the directory for the PID file
RUN mkdir /run/php

# Create the directory for PHP-FPM logs
RUN mkdir -p /var/log/php-fpm
# Set permissions for the directory
RUN chown -R www-data:www-data /var/log/php-fpm

COPY requirements/wordpress/conf/create_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wp.sh

# Copy the .conf in the html directory
COPY requirements/wordpress/conf/www.conf /etc/php/7.4/fpm/pool.d/

#we copy the script, give the right to launch it in local on our computer
ENTRYPOINT ["/usr/local/bin/create_wp.sh"]

CMD ["/usr/sbin/php-fpm7.4", "-F"]