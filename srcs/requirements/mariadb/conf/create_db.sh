
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
	service "$DB_NAME" start
fi

mysql -u root -p"${DB_ROOT}" <<EOF
CREATE DATABASE IF NOT EXISTS '${DB_NAME}'
CREATE USER IF NOT EXISTS '${DB_USER}' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
