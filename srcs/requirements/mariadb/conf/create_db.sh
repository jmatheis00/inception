#!/bin/bash

echo "DB_USER: $DB_USER"
echo "DB_PASS: $DB_PASS"
echo "DB_NAME: $DB_HOSTNAME"
echo "DB_ROOT: $DB_ROOTPASS"

if [ ! -d "/var/lib/mysql/$DB_DATABASE" ]; then
    service mariadb start
    sleep 4
    echo "Creating wordpress database..."
    mysql -u root -p"${DB_ROOTPASS}" <<EOF
    CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOTPASS';
    FLUSH PRIVILEGES;
EOF
    echo "$DB_DATABASE Database created successfully!"
    # sleep 2
    # mysqladmin --user=root --password=$DB_ROOTPASS shutdown
fi

echo "Outside of statement"
exec mysqld