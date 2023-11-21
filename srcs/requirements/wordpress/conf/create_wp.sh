#!/bin/bash


echo $DB_DATABASE
echo $DB_USER
echo $DB_PASS
echo $DB_HOSTNAME

####### MANDATORY PART ##########
# Create the PHP-FPM error log file if it doesn't exist
if [ ! -f /var/log/php-fpm/error.log ]; then
    mkdir -p /var/log/php-fpm
    touch /var/log/php-fpm/error.log
    chown -R www-data:www-data /var/log/php-fpm
fi

cd /var/www/html
# Download WordPress
wp core download --path=/var/www/html --allow-root

# Copy the sample config file
# cp wp-config-sample.php wp-config.php

# Remove existing directories
wp core is-installed --allow-root || wp core install --url=http://localhost --title="Inception Project jmatheis" \
	--admin_user=jmatheis --admin_password=wordpress --admin_email=jmatheis@student.42heilbronn.de --allow-root
wp core config --dbname="$DB_DATABASE" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost="$DB_HOSTNAME" --extra-php <<PHP
define( 'WP_DEBUG', false );
PHP

# Install WordPress
# wp core install --url=http://localhost --title="Inception Project jmatheis" --admin_user=jmatheis --admin_password=wordpress --admin_email=jmatheis@student.42heilbronn.de --allow-root
# 	#Download wordpress and all config file
# 	wget http://wordpress.org/latest.tar.gz
# 	tar xfz latest.tar.gz
# 	# Remove existing directories
# 	rm -rf ./wp-admin
# 	rm -rf ./wp-content
# 	rm -rf ./wp-includes
# 	mv wordpress/* .
# 	rm -rf latest.tar.gz
# 	rm -rf wordpress

# 	# Copy the sample config file
#     cp wp-config-sample.php /var/www/html/wp-config.php
# 	#Inport env variables in the config file
# 	sed -i "s/wordpress/$DB_DATABASE/g" /var/www/html/wp-config.php
# 	sed -i "s/jmatheis/$DB_USER/g" /var/www/html/wp-config.php
# 	sed -i "s/pass/$DB_PASS/g" /var/www/html/wp-config.php
# 	sed -i "s/mysql/$DB_HOSTNAME/g" /var/www/html/wp-config.php
# ###################################
# fi

exec "$@"

# The wp-config.php file you provided has placeholder values for the database configuration, which means it hasn't been configured with the actual database details. Update the following lines with the correct values: