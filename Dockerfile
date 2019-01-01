FROM php:7.3-fpm

MAINTAINER yi-ge <a@wyr.me>

ENV DEBIAN_FRONTEND noninteractive

COPY bin/* /usr/local/bin/
RUN chmod -R 700 /usr/local/bin/

# Apt utils
RUN apt-get update \
	&& apt-get install -y apt-utils

# Locales
RUN apt-get update \
	&& apt-get install -y locales

RUN dpkg-reconfigure locales \
	&& locale-gen C.UTF-8 \
	&& /usr/sbin/update-locale LANG=C.UTF-8

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen \
	&& locale-gen

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Common
RUN apt-get install -y \
		openssl \
		git \
		gnupg2


# PHP
# intl
RUN apt-get install -y libicu-dev \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install -j$(nproc) intl

# xml
RUN apt-get install -y \
	libxml2-dev \
	libxslt-dev \
	&& docker-php-ext-install -j$(nproc) \
		xmlrpc \
		xsl

# images
RUN apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libpng-dev \
	libgd-dev \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) \
		gd \
		exif

# database
RUN docker-php-ext-install -j$(nproc) \
	mysqli \
	pdo_mysql

# strings
RUN docker-php-ext-install -j$(nproc) \
	gettext

# math
RUN apt-get install -y libgmp-dev \
	&& ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
	&& docker-php-ext-install -j$(nproc) \
		gmp \
		bcmath

# zip
RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip

# compression
RUN apt-get install -y \
	libbz2-dev \
	zlib1g-dev \
	&& docker-php-ext-install -j$(nproc) \
		bz2

# memcached
RUN apt-get install -y \
	libmemcached-dev \
	libmemcached11


# others
RUN docker-php-ext-install -j$(nproc) \
	soap \
	sockets \
	calendar \
	sysvmsg \
	sysvsem \
	sysvshm

# ssh2
RUN apt-get install -y \
	libssh2-1-dev

RUN cd /tmp && git clone https://git.php.net/repository/pecl/networking/ssh2.git && cd /tmp/ssh2 \
&& phpize && ./configure && make && make install \
&& echo "extension=ssh2.so" > /usr/local/etc/php/conf.d/ext-ssh2.ini \
&& rm -rf /tmp/ssh2

# PECL
RUN docker-php-pecl-install \
	redis-4.2.0 \
	apcu-5.1.16 \
	xdebug-2.7.0beta1 \
	memcached-3.1.3

# Install XDebug, but not enable by default. Enable using:
# * php -d$XDEBUG_EXT vendor/bin/phpunit
# * php_xdebug vendor/bin/phpunit
ENV XDEBUG_EXT zend_extension=/usr/local/php/modules/xdebug.so
RUN alias php_xdebug="php -d$XDEBUG_EXT vendor/bin/phpunit"

# Install composer and put binary into $PATH
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

# Install PHP Code sniffer
RUN curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
	&& chmod 755 phpcs.phar \
	&& mv phpcs.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcs.phar /usr/local/bin/phpcs \
	&& curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar \
	&& chmod 755 phpcbf.phar \
	&& mv phpcbf.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcbf.phar /usr/local/bin/phpcbf

# Install PHPUnit
RUN curl -OL https://phar.phpunit.de/phpunit.phar \
	&& chmod 755 phpunit.phar \
	&& mv phpunit.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpunit.phar /usr/local/bin/phpunit

ADD php.ini /usr/local/etc/php/conf.d/docker-php.ini

# Clean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*
