FROM debian:11.3
RUN apt-get update -y && apt upgrade -y && apt-get install -y curl openssl zip unzip lsb-release apt-transport-https ca-certificates wget
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list && apt-get update
RUN apt-get update && apt -y install php7.4 php7.4-mysql php-curl php7.4-curl php7.4-xml
# RUN apt-get install -y php-curl php7.4.curl php7.4-xml
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer && apt-get update
RUN mkdir /var/www/html/laravel-app
COPY ./laravel-app /var/www/html/laravel-app
COPY ./vendor /var/www/html/laravel-app/vendor
WORKDIR /var/www/html/laravel-app
EXPOSE 8080
CMD composer update && exec php artisan serve --host=0.0.0.0 --port=8080
