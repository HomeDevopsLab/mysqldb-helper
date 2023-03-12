#!/bin/bash

MYSQL="/usr/bin/mysql"

function mysql_cmd() {
    $MYSQL -u ${DB_ADMIN_LOGIN} -p${DB_ADMIN_PASS} -h ${DB_HOST} -Nsre "$1"
}

function userExists() {
    result=$(mysql_cmd "SELECT count(User) FROM mysql.user WHERE User='${APPDB_LOGIN}'")
    echo $result
}

if [ $(userExists) == "1" ]; then
    mysql_cmd "ALTER USER '${APPDB_LOGIN}'@'%' IDENTIFIED BY '${APPDB_PASS}'"
    mysql_cmd "FLUSH PRIVILEGES"
else
    mysql_cmd "CREATE DATABASE ${APPDB_NAME}"
    mysql_cmd "CREATE USER '${APPDB_LOGIN}'@'%' IDENTIFIED BY '${APPDB_PASS}'"
    mysql_cmd "GRANT ALL ON ${APPDB_NAME}.* TO '${APPDB_LOGIN}'@'%'"
fi