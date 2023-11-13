FROM debian:11

EXPOSE 3306

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y mariadb-server mariadb-client \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY /requirements/mariadb/conf/my.cnf /etc/mysql/my.cnf
RUN mkdir -p /var/log/mysql /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/log/mysql /var/lib/mysql /var/run/mysqld

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

# Make the script executable
# Copy the script to the container
COPY /requirements/mariadb/conf/create_db.sh /create_db.sh
RUN chmod +x /create_db.sh
ENTRYPOINT ["/create_db.sh"]