#!/bin/bash
set -e

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_INIT_FLAG=/var/lib/mysql/.mariadb_initialized

# prepare the dir for data
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# My file-flag which get the script know about existing the database
if [ ! -f "$MYSQL_INIT_FLAG" ]; then
	# launch the server for initialization
	mysqld --user=mysql --console &
	pid="$!"

	# waiting until the server will be reachable
	until mysqladmin ping -uroot --socket=/run/mysqld/mysqld.sock --silent; do
		sleep 1
	done

	# configure the server (the conditions about if are already in sql-script)
	mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

	touch "$MYSQL_INIT_FLAG"
	# stop and wait the init process
	kill "$pid" || true
	wait "$pid" 2>/dev/null || true
fi

# execute the process in PID 1
exec mysqld --user=mysql --console
