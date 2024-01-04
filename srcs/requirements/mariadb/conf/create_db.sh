#!/bin/bash

echo "DB_USER: $DB_USER"

# Database set up
# creating a database, user, altering root user
if [ ! -d "/var/lib/mysql/$DB_DATABASE" ]; then
    service mariadb start
    sleep 4
    echo "Creating database and user..."
    mysql -u root -p"${DB_ROOTPASS}" -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
    mysql -u root -p"${DB_ROOTPASS}" -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
    mysql -u root -p"${DB_ROOTPASS}" -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
    mysql -u root -p"${DB_ROOTPASS}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOTPASS}';"
    mysql -u root -p"${DB_ROOTPASS}" -e "FLUSH PRIVILEGES;"
    sleep 2
    mysqladmin -u root -p$DB_ROOTPASS shutdown
    echo "Database setup completed successfully."
else
    echo "Database already exists. Skipping setup."
fi

# starting MariaDB
exec mysqld_safe