FROM mysql:8.0

COPY my.cnf /etc/mysql/my.cnf

# Đặt quyền chính xác để tránh bị MySQL bỏ qua file
RUN chmod 644 /etc/mysql/my.cnf
