FROM debian:bullseye

# RUN apt-get update && apt-get install -y netcat php php-form php-mysql wget tar curl && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    netcat \
    php \
    php-fpm \
    php-mysql \
    curl \
    wget \
    tar \
	unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

# RUN wget https://wordpress.org/latest.zip && \
# 	unzip latest.zip && \
# 	rm latest.zip && \
# 	mv wordpress/* . && \
# 	rmdir wordpress

RUN chown -R www-data:www-data /var/www/html

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/setup_wp.sh /setup_wp.sh

RUN chmod +x /setup_wp.sh

EXPOSE 9000

# PID 1 - php-form
ENTRYPOINT ["/setup_wp.sh"]