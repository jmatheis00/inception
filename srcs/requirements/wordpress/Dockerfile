FROM debian:11

RUN apt-get update && apt-get -y install \
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
  && mv wp-cli.phar /usr/local/bin/wp

# Copy the .conf in the html directory
COPY requirements/wordpress/conf/www.conf /etc/php/7.4/fpm/pool.d/
# Create the directory for the PID file
RUN mkdir /run/php

#we copy the script, give the right to launch it in local on our computer
COPY requirements/wordpress/conf/create_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wp.sh
ENTRYPOINT ["/usr/local/bin/create_wp.sh"]

WORKDIR /var/www/html
EXPOSE 9000
CMD ["/usr/sbin/php-fpm7.4", "-F"]