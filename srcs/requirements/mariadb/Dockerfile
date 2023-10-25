FROM debian:11

ARG DB_NAME
ARG DB_USER
ARG DB_PASS

ENV MYSQL_DATABASE=$DB_NAME \
    MYSQL_USER=$DB_USER \
    MYSQL_PASSWORD=$DB_PASS

#updates package repositories, installs mariadb and mariadb-client
RUN apt-get update && apt-get install -y mariadb-server mariadb-client \
  && apt-get clean && \
  rm -rf /var/lib/apt/lists/*

#creates mysqld dir + permissions
RUN mkdir /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql \
    && chmod 777 /var/run/mysqld

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

#copies .sh into current working dir & runs it
COPY requirements/mariadb/conf/create_db.sh .
RUN chmod +x create_db.sh && ./create_db.sh && rm create_db.sh
USER mysql
CMD ["mysqld", "--bind-address=0.0.0.0"]
