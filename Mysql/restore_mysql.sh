#!/bin/bash

# Tên container MySQL (trùng docker-compose.yml)
CONTAINER_NAME="mysql_server"

# Thông tin đăng nhập MySQL
USER="root"
PASSWORD="rootpassword"

# Hỏi người dùng nhập file .sql
read -p "Nhập đường dẫn đầy đủ hoặc tên file .sql cần restore: " SQL_FILE

# Kiểm tra file có tồn tại không
if [ ! -f "$SQL_FILE" ]; then
  echo "❌ File $SQL_FILE không tồn tại!"
  exit 1
fi

echo "⚡ Đang restore từ file: $SQL_FILE ..."

# Thực hiện restore
docker exec -i $CONTAINER_NAME \
  mysql -u$USER -p$PASSWORD < "$SQL_FILE"

if [ $? -eq 0 ]; then
  echo "✅ Restore thành công!"
else
  echo "❌ Restore thất bại!"
fi
