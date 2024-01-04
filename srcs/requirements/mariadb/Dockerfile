FROM debian:11

EXPOSE 3306

RUN apt-get update \
	&& apt-get install -y mariadb-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY /requirements/mariadb/conf/my.cnf /etc/mysql/my.cnf

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

# Make the script executable & copy the script to the container
COPY /requirements/mariadb/conf/create_db.sh /usr/local/bin/create_db.sh
RUN chmod +x /usr/local/bin/create_db.sh

ENTRYPOINT ["/usr/local/bin/create_db.sh"]