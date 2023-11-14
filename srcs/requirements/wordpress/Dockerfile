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

# Create the directory to store WordPress files
RUN mkdir -p /var/www

# Create the directory for the PID file
RUN mkdir -p /run/php

# Download & extract Wordpress
RUN wget https://wordpress.org/latest.tar.gz -O /tmp/latest.tar.gz \
    && tar -xzvf /tmp/latest.tar.gz -C /var/www \
    && rm /tmp/latest.tar.gz

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/wordpress
RUN chown -R www-data:www-data /var/run/php

COPY requirements/wordpress/conf/www.conf /etc/php/7.4/fpm/pool.d

#we copy the script, give the right to launch it in local on our computer
COPY requirements/wordpress/conf/create_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wp.sh
ENTRYPOINT ["/usr/local/bin/create_wp.sh"]

WORKDIR /var/www/html
EXPOSE 9000
CMD ["php-fpm7.4"]