#!/bin/bash
if [ ! -f "/app/index.php" ]; then
    cp -rf /wln/app/* /app
fi
if [ ! -f "/app/data/index.html" ]; then
    cp -rf /wln/data/* /app/data
fi
chmod -R 777 /app
sed -i "s/AllowOverride All/AllowOverride None/g" /etc/apache2/apache2.conf
sed -i "s/Options +Indexes/Options -Indexes/g" /etc/apache2/apache2.conf
a2enmod rewrite

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND