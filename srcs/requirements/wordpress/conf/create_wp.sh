#!/bin/bash


echo $DB_DATABASE
echo $DB_USER
echo $DB_PASS
echo $DB_HOSTNAME

# Wait for the MySQL server to be ready
# echo "Waiting for MariaDB server to be ready..."
# until mysql --host=mariadb --user="$DB_USER" --password="$DB_PASS" -e '\c'; do
#     echo "MariaDB is not ready yet. Retrying in 3 seconds..."
#     sleep 1
# done

echo "MariaDB server is ready. Proceeding with WordPress setup."

cd /var/www/html
# Download WordPress
wp-cli core download --path=/var/www/html --allow-root

# Copy the sample config file
cp wp-config-sample.php wp-config.php

# Use sed to replace placeholder values with actual database details
sed -i "s/'database_name_here'/'$DB_DATABASE'/g" wp-config.php
sed -i "s/'username_here'/'$DB_USER'/g" wp-config.php
sed -i "s/'password_here'/'$DB_PASS'/g" wp-config.php
sed -i "s/'localhost'/'$DB_HOSTNAME'/g" wp-config.php

# Remove existing directories
wp-cli core is-installed --allow-root || wp-cli core install --allow-root --url=http://localhost --title="Inception Project jmatheis" \
	--admin_user=jmatheis --admin_password=wordpress --admin_email=jmatheis@student.42heilbronn.de --allow-root
wp-cli core config --allow-root --dbname="$DB_DATABASE" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost="$DB_HOSTNAME" --extra-php <<PHP
define( 'WP_DEBUG', false );
PHP

exec "$@"