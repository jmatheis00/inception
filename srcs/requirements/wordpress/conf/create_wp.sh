#!/bin/bash

echo $DB_DATABASE
echo $DB_USER
echo $DB_HOSTNAME

cd /var/www/html

# Create Wordpress Admin, 
if ! wp-cli core is-installed --allow-root; then
	# Download WordPress core files without installing or configuring them
	wp-cli core download --path=/var/www/html --allow-root
	# # Copy the sample config file
	cp wp-config-sample.php wp-config.php

	# # edit wp-config.php file, replacing placeholder values
	sed -i "s/'database_name_here'/'$DB_DATABASE'/g" wp-config.php
	sed -i "s/'username_here'/'$DB_USER'/g" wp-config.php
	sed -i "s/'password_here'/'$DB_PASS'/g" wp-config.php
	sed -i "s/'localhost'/'$DB_HOSTNAME'/g" wp-config.php
	# # core install completes the installation
	wp-cli core install --allow-root --url=http://localhost --title="Inception Project jmatheis" \
		--admin_user=jmatheis --admin_password=wordpress --admin_email=jmatheis@student.42heilbronn.de --allow-root
	# Add another user
	wp-cli user create exampleuser juliamatheis@gmx.de --role=author --user_pass=example --allow-root
	# Install a theme
	wp-cli theme install twentytwentytwo --activate --allow-root
else
	echo "WordPress already installed. Skipping set up."
fi

exec "$@"