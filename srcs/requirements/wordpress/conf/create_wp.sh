#!/bin/bash

# set -e

# #create wp-config.php
# sudo -u jmatheis -i wp config create --dbname=$DB_DATABASE --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOSTNAME --dbprefix=wp_ --skip-check

# #Install WordPress
# sudo -u jmatheis -i wp core install --url=http://jmatheis.42.fr --title="Inception" --admin_user="jmatheis" --admin_password="wordpress"

# # Update permalinks
# sudo -u jmatheis -i wp rewrite structure '/%postname%/' --hard

# # Start the web server
# exec apache2ctl -D FOREGROUND

#check if wp-config.php exist
# if [ -f ./wp-config.php ]
# then
# 	echo "wordpress already downloaded"
# else

####### MANDATORY PART ##########
# Create the PHP-FPM error log file if it doesn't exist
if [ ! -f /var/log/php-fpm/error.log ]; then
    mkdir -p /var/log/php-fpm
    touch /var/log/php-fpm/error.log
    chown -R www-data:www-data /var/log/php-fpm
fi
	#Download wordpress and all config file
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	# Copy the sample config file
    cp wp-config-sample.php wp-config.php
	#Inport env variables in the config file
	sed -i "s/wordpress/$DB_DATABASE/g" wp-config.php
	sed -i "s/jmatheis/$DB_USER/g" wp-config.php
	sed -i "s/pass/$DB_PASS/g" wp-config.php
	sed -i "s/mysql/$DB_HOSTNAME/g" wp-config.php
###################################
# fi

exec "$@"

# The wp-config.php file you provided has placeholder values for the database configuration, which means it hasn't been configured with the actual database details. Update the following lines with the correct values: