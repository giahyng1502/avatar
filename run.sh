#!/bin/bash

echo "======================================"
echo "    KHOI DONG SERVER AVATAR DOCKER    "
echo "======================================"

# Kiem tra va cap nhat file database.properties cho phu hop voi Docker
if [ -f "database.properties" ]; then
    echo "[1/3] Cap nhat cau hinh database.properties..."
    # Đổi host thành tên container db trong docker-compose
    sed -i.bak 's/host=127.0.0.1/host=db/g' database.properties
    # Sửa lỗi chính tả passeword trong file config theo mã nguồn Java
    sed -i.bak 's/password=rootpassword/passeword=rootpassword/g' database.properties
    rm -f database.properties.bak
else
    echo "Khong tim thay file database.properties!"
fi

echo "[2/3] Dang build va khoi dong cac container Docker..."
# Chạy docker compose ở chế độ ngầm (-d) và tự động build lại image nếu có thay đổi
docker compose up -d --build

echo "[3/3] HOAN TAT!"
echo ""
echo "Ban co the xem log cua server bang lenh: docker compose logs -f server"
echo "======================================"
