# Create a custom MariaDB configuration file
# cat << EOF > /etc/mysql/mariadb.conf.d/custom.cnf
# [mysqld]
# log_error = /var/log/mysql/error.log
# EOF

# Ensure the log file exists and is writable by the MySQL user
# touch /var/log/mysql/error.log
# chown mysql:mysql /var/log/mysql/error.log

# If mysql does not exist --> create it
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
	mysql -u root -p"${DB_ROOT}" << EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS ${DB_USER} IDENTIFIED BY ${DB_PASS};
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO ${DB_USER}@'%';
FLUSH PRIVILEGES;
EOF
fi

# if wordpress does not exist --> create it
if [ ! -d "/var/lib/mysql/wordpress" ]; then
	mysql -u root -p"${DB_ROOT}" <<EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
fi
