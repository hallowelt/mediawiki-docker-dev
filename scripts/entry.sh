#!/bin/bash

GIT_REPO="https://github.com/hallowelt/mediawiki.git"
GIT_BRANCH="master"
DEST_PATH="/var/www/html/bluespice"
fileWikiSysopPass=$DEST_PATH/wikisysop_password.txt

if [ ! -d $DEST_PATH ] ; then
	git clone -b $GIT_BRANCH --depth 1 $GIT_REPO $DEST_PATH
fi

if [ ! -f $fileWikiSysopPass ]; then
   WIKI_ADMIN_PASS=$(openssl rand -base64 32)
   echo $WIKI_ADMIN_PASS > $fileWikiSysopPass
else
   WIKI_ADMIN_PASS=$( cat $fileWikiSysopPass )
fi

cd $DEST_PATH; composer update && composer update

if [ ! -f $DEST_PATH/LocalSettings.php ] ; then
	cd "$DEST_PATH"; php maintenance/install.php --dbserver db --dbname bluespice_mediawiki --dbuser root --dbpass docker --pass $WIKI_ADMIN_PASS --scriptpath /bluespice "$WIKI_NAME" "$WIKI_ADMIN"
fi

php ${DEST_PATH}/maintenance/update.php --quick

/usr/sbin/apache2ctl -D FOREGROUND
