# php

Fork https://hub.docker.com/r/phpdocker/phpdocker/, remove MariaDB、Redis、Node.js，update php to 7.3。

## PHP 7.3 Official Images Modules

Many extensions are already compiled into the `Official Images`.

```
[PHP Modules]
Core
ctype
curl
date
dom
fileinfo
filter
ftp
hash
iconv
json
libxml
mbstring
mysqlnd
openssl
pcre
PDO
pdo_sqlite
Phar
posix
readline
Reflection
session
SimpleXML
sodium
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
zlib
```

## Usage

DockerHub:
```
docker pull wy373226722/php:7.3
```

中国：
```
docker pull registry.cn-shenzhen.aliyuncs.com/yi-ge/php:7.3
```

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
