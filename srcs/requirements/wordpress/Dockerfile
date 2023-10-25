FROM debian:11
ARG DB_NAME \
    DB_USER \
    DB_PASS
RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-mysqli \
    php7.4-zip \
    curl \
    wget \
    unzip \
    bash \
    libzip-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www

RUN wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && cp -rf wordpress/* . \
    && rm -rf wordpress latest.zip

RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

COPY ./requirements/wordpress/conf/wp-config-create.sh .
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

CMD ["/usr/sbin/php-fpm7.4", "-F"]