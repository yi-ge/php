# php

Fork https://hub.docker.com/r/phpdocker/phpdocker/, remove MariaDB、Redis、Node.js，update php to 7.3。

## Usage

* Docker image is available at [Docker Hub](https://hub.docker.com/r/phpdocker/phpdocker/).
* The primary goal of this Docker image is custom image for CI, but you can use it like you want.

## Example

* [Shippable CI](https://bitbucket.org/hranicka/composer-sandbox/src/master/shippable.yml?at=master&fileviewer=file-view-default) custom container

## Tags

* Tags depend on version of PHP included.
* They are given by git branches.
* You can see them at [Docker Hub](https://hub.docker.com/r/phpdocker/phpdocker/tags/).

---

## Available Bash scripts

### [check-status-code](bin/check-status-code)

This performs a HTTP Request and checks returned status code.

Returns non-zero exit code when status is not 200 (OK).

Usage: `URL="https://www.example.com" check-status-code`

Returns non-zero exit code when status is not 403 (Forbidden).

Usage: `URL="https://www.example.com" STATUS=403 check-status-code`

## Built-in applications

* [GIT](https://git-scm.com/)
* [PHP](http://php.net) (from official [PHP Docker images](https://registry.hub.docker.com/_/php/))
	* [XDebug](http://xdebug.org)
		* XDebug is not enabled by default, see i.e. [Composer docs](https://getcomposer.org/doc/articles/troubleshooting.md#xdebug-impact-on-composer)
		* You can run script with XDebug enabled like: `php -d$XDEBUG_EXT vendor/bin/phpunit` or `php_xdebug vendor/bin/phpunit`
	* [SSH2](http://php.net/ssh2)
	* [Redis](http://redis.io)
	* [APCu](http://php.net/apcu)
	* [Memcached](http://php.net/manual/en/book.memcached.php)
* [Composer](https://getcomposer.org)
* [PHP_CodeSniffer](https://www.squizlabs.com/php-codesniffer) 
* [PHPUnit](https://phpunit.de)

### Composer

* Composer is installed globally.
* You can run it, eg. `composer self-update`.

### PHP_CodeSniffer

* PHP_CodeSniffer is installed globally.
* You can run it, eg. `phpcs --standard=PSR2 -nsp src tests`.

### PHPUnit

* PHPUnit is installed globally.
* You can run it, eg. `phpunit --log-junit shippable/testresults/junit.xml --coverage-xml shippable/codecoverage -c tests/configuration.xml tests`.
