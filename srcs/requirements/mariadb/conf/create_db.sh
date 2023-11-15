#!/bin/bash

echo "DB_USER: $DB_USER"
echo "DB_PASS: $DB_PASS"
echo "DB_NAME: $DB_HOSTNAME"
echo "DB_ROOT: $DB_ROOTPASS"

# Start MySQL server if its not already running
# if ! service mariadb status > /dev/null; then
    service mariadb start
# fi

# Create initial database and user
echo "Creating initial database and user..."
mysql -u root -p"${DB_ROOTPASS}" <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_HOSTNAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_HOSTNAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# echo "initial database '$DB_NAME' and user '$DB_USER' created successfully!"

if [ ! -d "/var/lib/mysql/$DB_DATABASE" ]; then
    echo "Creating wordpress database..."
    mysql -u root -p"${DB_ROOTPASS}" <<EOF
    USE ${DB_HOSTNAME};
    CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    FLUSH PRIVILEGES;
EOF

    #Import database in the mysql command line
    mysql -uroot -p$DB_ROOTPASS $DB_DATABASE < /usr/local/bin/wordpress.sql
    echo "$DB_DATABASE Database created successfully!"
else
    echo "$DB_DATABASE Database already exists"
fi

exec mysqld