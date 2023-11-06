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
RUN chmod +x ./create_db.sh

# RUN /create_db.sh


# Use shell as the entrypoint and specify both MySQL startup and script execution in CMD
ENTRYPOINT ["/create_db.sh"]

# CMD ["/create_db.sh"]
# CMD ["mysqld", "--log-error=/var/log/mysql/error.log", "--datadir=/var/lib/mysql"]

# Copy your custom MariaDB configuration file into the container
# RUN mkdir -p /var/log/mysql/
# # Copy the script into the container
# COPY /requirements/mariadb/conf/create_db.sh /create_db.sh

# COPY /requirements/mariadb/conf/entrypoint.sh /entrypoint.sh
# # Make the script executable
# RUN chmod +x /create_db.sh /entrypoint.sh

# # Execute the script and remove it
# RUN /create_db.sh && rm /create_db.sh

# RUN mkdir -p /var/run/mysqld/
# RUN chown -R mysql:mysql /var/run/mysqld/
# Set entry point
# ENTRYPOINT ["/entrypoint.sh"]