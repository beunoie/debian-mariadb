#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

MYSQL_CNF=/etc/mysql/my.cnf

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    mysql_install_db > /dev/null 2>&1
    /root/create_mariadb_admin_user.sh
fi

exec mysqld_safe --defaults-file=$MYSQL_CNF
