#!/bin/bash

# Tên container GitLab
CONTAINER_NAME="gitlab"

# Hỏi host chính
read -p "Nhập host chính cho GitLab (ví dụ: https://gitlab.example.com): " MAIN_HOST

# Hỏi host registry
read -p "Nhập host cho Container Registry (ví dụ: https://registry.example.com): " REGISTRY_HOST

# Hỏi cổng SSH (nếu bạn dùng map port, ví dụ 1422)
read -p "Nhập cổng SSH GitLab (ví dụ: 22 hoặc 1422): " SSH_PORT

echo "⚡ Đang cập nhật cấu hình GitLab ..."

# Chạy trong container GitLab
docker exec -i $CONTAINER_NAME bash <<EOF
set -e

CONFIG_FILE="/etc/gitlab/gitlab.rb"

# Backup file cũ
cp \$CONFIG_FILE \$CONFIG_FILE.bak_\$(date +%Y%m%d%H%M%S)

# Ghi lại cấu hình mới
cat > \$CONFIG_FILE <<EOC
external_url "$MAIN_HOST"

gitlab_rails['gitlab_shell_ssh_port'] = $SSH_PORT

registry['enable'] = true
registry_external_url "$REGISTRY_HOST"

gitlab_rails['time_zone'] = 'Asia/Ho_Chi_Minh'
EOC

# Áp dụng thay đổi
gitlab-ctl reconfigure
gitlab-ctl restart
EOF

if [ $? -eq 0 ]; then
  echo "✅ Cập nhật host GitLab & Registry thành công!"
else
  echo "❌ Có lỗi khi cập nhật cấu hình!"
fi
