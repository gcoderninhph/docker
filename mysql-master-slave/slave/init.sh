#!/bin/bash
set -e

MASTER_HOST="192.168.1.101"
MASTER_PORT=3406
ROOT_PASS="rootpass"
REPL_USER="repl"
REPL_PASS="replpass"

# Đợi master sẵn sàng
until mysqladmin ping -h $MASTER_HOST -P$MASTER_PORT -u$REPL_USER -p$REPL_PASS --silent; do
  echo "Waiting for master..."
  sleep 2
done

# Lấy binlog và vị trí
LOG_FILE=$(mysql -h$MASTER_HOST -P$MASTER_PORT -uroot -p$ROOT_PASS -e "SHOW MASTER STATUS\G" | grep File | awk '{print $2}')
LOG_POS=$(mysql -h$MASTER_HOST -P$MASTER_PORT -uroot -p$ROOT_PASS -e "SHOW MASTER STATUS\G" | grep Position | awk '{print $2}')

# Cấu hình replication
mysql -uroot -p$ROOT_PASS <<-EOSQL
STOP SLAVE;
CHANGE MASTER TO
  MASTER_HOST='$MASTER_HOST',
  MASTER_PORT=$MASTER_PORT,
  MASTER_USER='$REPL_USER',
  MASTER_PASSWORD='$REPL_PASS',
  MASTER_LOG_FILE='$LOG_FILE',
  MASTER_LOG_POS=$LOG_POS;
START SLAVE;
EOSQL
