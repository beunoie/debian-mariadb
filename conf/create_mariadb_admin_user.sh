#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MariaDB service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

PASS="password"
MYSQL_ADMIN_USER="admin"
MYSQL_ADMIN_HOST="%"
_word=$( [ ${MYSQL_ADMIN_PASS} ] && echo "preset" || echo "random" )

mysql -uroot -e "CREATE USER '$MYSQL_ADMIN_USER'@'$MYSQL_ADMIN_HOST' IDENTIFIED BY '$PASS'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ADMIN_USER'@'$MYSQL_ADMIN_HOST' WITH GRANT OPTION"

echo "=> Done!"

mysqladmin -uroot shutdown
