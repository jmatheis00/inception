#!/bin/bash
exec > >(tee -a /var/log/create_db.log)
exec 2>&1

set -e

sleep 10

echo "Creating initial database and user..."
echo "DB_USER: $DB_USER"
echo "DB_PASS: $DB_PASS"
echo "DB_NAME: $DB_NAME"
echo "DB_ROOT: ${DB_ROOT}"

# Create initial database and user
mysql -u root -p"${DB_ROOT}" <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "initial database '$DB_NAME' and user '$DB_USER' created successfully!"
sleep 5

echo "Creating wordpress database..."
mysql -u root -p"${DB_ROOT}" <<EOF
USE ${DB_NAME};
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "WordPress database created successfully!"