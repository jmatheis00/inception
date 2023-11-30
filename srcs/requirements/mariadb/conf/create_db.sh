#!/bin/bash

echo "DB_USER: $DB_USER"
echo "DB_PASS: $DB_PASS"
echo "DB_NAME: $DB_HOSTNAME"
echo "DB_ROOT: $DB_ROOTPASS"

# Initialize MariaDB

# Performing root user setup
# echo "Root user setup: mysql -u root -p${DB_ROOTPASS} --socket=/var/run/mysqld/mysqld.sock -e \"ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOTPASS';\""
# mysql -u root -p"${DB_ROOTPASS}" --socket=/var/run/mysqld/mysqld.sock -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOTPASS';"

# Perform database setup
if [ ! -d "/var/lib/mysql/$DB_DATABASE" ]; then
    service mariadb start
    sleep 4
    echo "Creating database and user..."
    mysql -u root -p"${DB_ROOTPASS}" <<EOF
    CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    FLUSH PRIVILEGES;
EOF
    echo "Database setup completed successfully."
    sleep 2
    service mariadb stop
else
    echo "Database already exists. Skipping setup."
fi

# Clean up

# Additional logging
exec "mysqld_safe"