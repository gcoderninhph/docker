2) Đăng nhập lần đầu

Truy cập: http://gitlab.example.com

Tài khoản: root

Mật khẩu lần đầu: nằm trong container ở file:

docker exec -it gitlab bash -lc "cat /etc/gitlab/initial_root_password"


(mật khẩu này hết hạn sau 24h; bạn sẽ được yêu cầu đặt lại khi đăng nhập)