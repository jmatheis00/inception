FROM debian:11

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y mariadb-server mariadb-client \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld/
RUN chown -R mysql:mysql /var/run/mysqld/

EXPOSE 3306

# Copy the script into the container
COPY /requirements/mariadb/conf/create_db.sh /docker-entrypoint-initdb.d/create_db.sh

# Grant execution permissions to the script
RUN chmod +x /docker-entrypoint-initdb.d/create_db.sh

CMD ["mysqld", "--skip-log-error"]