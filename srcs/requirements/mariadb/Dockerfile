FROM debian:11

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y mariadb-server mariadb-client \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Copy your custom MariaDB configuration file into the container
# RUN mkdir -p /var/log/mysql/
COPY /requirements/mariadb/conf/my.cnf /etc/mysql/my.cnf

# # Copy the script into the container
COPY /requirements/mariadb/conf/create_db.sh /create_db.sh

COPY /requirements/mariadb/conf/entrypoint.sh /entrypoint.sh
# # Make the script executable
RUN chmod +x /create_db.sh /entrypoint.sh

# # Execute the script and remove it
# RUN /create_db.sh && rm /create_db.sh

RUN mkdir -p /var/run/mysqld/
RUN chown -R mysql:mysql /var/run/mysqld/


EXPOSE 3306

# CMD ["mysqld", "--skip-log-error"]
# Set entry point
ENTRYPOINT ["/entrypoint.sh"]