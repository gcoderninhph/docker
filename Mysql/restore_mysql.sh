#!/bin/bash

# Tên container MySQL (trùng docker-compose.yml)
CONTAINER_NAME="mysql_server"

# Hỏi người dùng nhập file .sql
read -p "Nhập đường dẫn đầy đủ hoặc tên file .sql cần restore: " SQL_FILE

# Kiểm tra file có tồn tại không
if [ ! -f "$SQL_FILE" ]; then
  echo "❌ File $SQL_FILE không tồn tại!"
  exit 1
fi

# Hỏi thông tin đăng nhập MySQL
read -p "Nhập MySQL user: " USER
read -s -p "Nhập MySQL password: " PASSWORD
echo ""   # xuống dòng cho đẹp

echo "⚡ Đang restore từ file: $SQL_FILE với user: $USER ..."

# Thực hiện restore
docker exec -i $CONTAINER_NAME \
  mysql -u$USER -p$PASSWORD < "$SQL_FILE"

if [ $? -eq 0 ]; then
  echo "✅ Restore thành công!"
else
  echo "❌ Restore thất bại!"
fi
