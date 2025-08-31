#!/bin/bash

# Tên container MySQL (trùng với docker-compose.yml)
CONTAINER_NAME="mysql_server"

# Thông tin đăng nhập MySQL
USER="root"
PASSWORD="12345678"

# Tên file dump (có timestamp để tránh trùng)
OUTPUT_FILE="dump_all_$(date +%Y%m%d_%H%M%S).sql"

# Dump toàn bộ database
docker exec -i $CONTAINER_NAME \
  mysqldump -u$USER -p$PASSWORD --all-databases > "$OUTPUT_FILE"

echo "✅ Đã dump toàn bộ MySQL. File lưu tại: $OUTPUT_FILE"
