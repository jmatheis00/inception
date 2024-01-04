#!/bin/bash

echo $DB_DATABASE
echo $WP_ADMINUSER
echo $WP_ADMIN_MAIL

cd /var/www/html

# wait for mariadb to be ready
until mysql -h $DB_HOSTNAME -u $DB_USER -p$DB_PASS -e '' 2>/dev/null;do
	echo "waiting for mariadb..."
	sleep 1
done

# Create Wordpress Admin, 
if ! wp-cli core is-installed --path=/var/www/html --allow-root 2>/dev/null; then
	echo "Download Wordpress core file"
	# Download WordPress core files
	wp-cli core download --path=/var/www/html --allow-root

	# configure & create wp config file
	echo "Replacing placeholders"
	wp-cli config create --path=/var/www/html --allow-root \
		--dbname=$DB_DATABASE --dbuser=$DB_USER \
		--dbpass=$DB_PASS --dbhost=$DB_HOSTNAME

	# core install completes the installation
	echo "core install"
	wp-cli core install --url=$DOMAIN_NAME --title=$WP_TITLE \
		--admin_user=$WP_ADMINUSER --admin_password=$WP_ADMINPASS \
		--admin_email=$WP_ADMINMAIL --allow-root
	
	# Add another user
	echo "add another user"
	wp-cli user create $WP_OTHERUSER $WP_OTHERMAIL --role=author --user_pass=$WP_OTHERPASS --allow-root
	
	# Install a theme
	echo "install theme"
	wp-cli theme install twentytwentytwo --activate --allow-root
else
	echo "WordPress already installed. Skipping set up."
fi

exec "$@"