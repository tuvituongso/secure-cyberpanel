#!/bin/bash

# === Auto Secure CyberPanel for Ubuntu 22.04 ===
echo "🚀 Bắt đầu thiết lập bảo mật cơ bản cho VPS..."

# --- Bước 1: Cập nhật hệ thống ---
echo "🛠️ Đang cập nhật hệ thống..."
apt update && apt upgrade -y

# --- Bước 2: Cài công cụ cần thiết ---
apt install -y ufw fail2ban curl wget nano sudo

# --- Bước 3: Đổi port SSH ---
SSH_PORT=2288
echo "🔒 Đổi port SSH sang $SSH_PORT"
sed -i "s/#Port 22/Port $SSH_PORT/" /etc/ssh/sshd_config
ufw allow $SSH_PORT/tcp
systemctl restart sshd

# --- Bước 4: Thiết lập UFW firewall ---
echo "🛡️ Cấu hình tường lửa UFW..."
ufw allow 80,443,8090/tcp
ufw allow 21,40110:40210/tcp
ufw --force enable

# --- Bước 5: Cài & cấu hình Fail2Ban ---
echo "🛡️ Cấu hình Fail2Ban chống brute force..."
cat > /etc/fail2ban/jail.local <<EOF
[sshd]
enabled = true
port = $SSH_PORT
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
bantime = 3600
findtime = 600
EOF
systemctl enable fail2ban --now
systemctl restart fail2ban

# --- Bước 6: Bổ sung DNS resolver nếu cần ---
echo "🌐 Kiểm tra DNS resolver..."
echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" > /etc/resolv.conf

# --- Bước 7: Cảnh báo xong ---
echo "✅ Đã hoàn tất bảo mật cơ bản cho VPS Ubuntu 22.04"
echo "🔐 Hãy đăng nhập SSH bằng port mới: $SSH_PORT"
echo "🌐 Đăng nhập CyberPanel tại: https://<IP>:8090"
