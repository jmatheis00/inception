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
COPY /requirements/mariadb/conf/create_db.sh /usr/local/bin/create_db.sh
RUN chmod +x /usr/local/bin/create_db.sh
# COPY /requirements/mariadb/conf/wp.sql /usr/local/bin/
# RUN chmod +x /usr/local/bin/wp.sql

ENTRYPOINT ["/usr/local/bin/create_db.sh"]
# mysqld becomes the main process for the container
# Command to launch mariadb and enable the database to listen globally
CMD ["mysqld", "--bind-address=0.0.0.0"]