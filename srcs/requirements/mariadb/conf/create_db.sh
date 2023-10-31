
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
	service "$DB_NAME" start
	mysql -u root -p"${DB_ROOT}" << EOF
	CREATE DATABASE IF NOT EXISTS ${DB_NAME};
	CREATE USER IF NOT EXISTS ${DB_USER} IDENTIFIED BY ${DB_PASS};
	GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO ${DB_USER}@'%';
	FLUSH PRIVILEGES;
	EOF
	service "$DB_NAME" stop
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then

    cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM     mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
	# run init.sql
	/usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
	rm -f /tmp/create_db.sql
fi