#!/bin/sh
set -eu

echo "Starting MariaDB entrypoint script..."
# Load environment variables from the .env file
ROOT_PW=$(cat $MYSQL_ROOT_PASSWORD_FILE)
DB_PW=$(cat $MYSQL_PASSWORD_FILE)

printenv | grep MYSQL
echo "Root password: $ROOT_PW"
echo "Database password: $DB_PW"
echo "Database User: $MYSQL_USER"
echo "Database Name: $MYSQL_DATABASE"

if [ ! -d /var/lib/mysql/mysql ]; then
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
  mysqld --user=mysql --bootstrap  << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '$ROOT_PW';
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$DB_PW';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
fi

exec mysqld --user=mysql --datadir=/var/lib/mysql 