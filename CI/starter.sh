#!/bin/sh
mysqld_safe &
sleep 60
mysql -e "CREATE DATABASE wiki;"
mysql -e "CREATE USER 'thoughtworks'@localhost IDENTIFIED BY 'THISpasswordSHOULDbeCHANGED';"
mysql -e "GRANT ALL PRIVILEGES ON wiki.* TO 'thoughtworks'@'localhost'";
mysql -e "FLUSH PRIVILEGES;"
service apache2 start
tail -f /dev/null #find a way to make apache run in foreground