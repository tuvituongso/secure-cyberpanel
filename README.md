# Auto Secure Script for CyberPanel on Ubuntu 22.04

## 🧩 Tính năng script:
- Cập nhật hệ thống
- Đổi port SSH mặc định (22 ➜ 2288)
- Cài & cấu hình UFW firewall
- Cài & bật Fail2Ban chống brute-force
- Bổ sung DNS resolver ổn định

## 🛠️ Cách sử dụng:
```bash
chmod +x secure.sh
sudo ./secure.sh
```

## 📌 Ghi chú:
- SSH port mới: **2288**
- Đăng nhập CyberPanel: `https://<IP-VPS>:8090`
- Nếu dùng firewall cloud (như AWS, Vultr), nhớ mở port tương ứng.
