FROM debian:stretch

RUN apt-get update && apt-get -y install apache2

RUN apt-get update && apt-get -y install php7.0 php7.0-mysql php7.0-mbstring php7.0-json php7.0-curl php7.0-xml php7.0-gd php7.0-tidy php7.0-intl php7.0-ldap curl apache2-mod-php7.0

RUN apt-get update && apt-get -y install tomcat8

RUN apt-get update && apt-get -y install unzip rsync zip

RUN apt-get update && apt-get -y install git-core

RUN apt-get update && apt-get -y install cron inotify-tools

RUN apt-get update && apt-get install -y python memcached

RUN apt-get update && apt-get install -y gnupg2 && curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs

RUN apt-get update && apt-get install wget && wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -

RUN apt-get update && apt-get install apt-transport-https && echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list

RUN apt-get update && apt-get install elasticsearch

RUN apt-get update && apt-get install -y composer

WORKDIR /var/www/html
EXPOSE 80

ENV WIKI_NAME="BlueSpice MediaWiki"
ENV WIKI_ADMIN="WikiSysop"

COPY scripts/* /usr/sbin/

VOLUME /var/www/html/

ENTRYPOINT /usr/sbin/entry.sh
