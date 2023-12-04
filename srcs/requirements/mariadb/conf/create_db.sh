#!/bin/bash

echo "DB_USER: $DB_USER"
echo "DB_PASS: $DB_PASS"
echo "DB_NAME: $DB_HOSTNAME"
echo "DB_ROOT: $DB_ROOTPASS"

# Database set up
# creating a database, user, altering root user
if [ ! -d "/var/lib/mysql/$DB_DATABASE" ]; then
    service mariadb start
    sleep 4
    echo "Creating database and user..."
    mysql -u root -p"${DB_ROOTPASS}" <<EOF
    CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOTPASS}';
    FLUSH PRIVILEGES;
EOF
    echo "Database setup completed successfully."
    sleep 2
    service mariadb stop
else
    echo "Database already exists. Skipping setup."
fi

# starting MariaDB
exec mysqld_safe