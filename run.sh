#!/bin/bash
echo "======================================"
echo "    KHOI DONG SERVER AVATAR DOCKER    "
echo "======================================"

if [ -f "database.properties" ]; then
    echo "[1/3] Cap nhat cau hinh database.properties..."
    sed -i.bak 's/host=127.0.0.1/host=db/g' database.properties
    sed -i.bak 's/password=rootpassword/passeword=rootpassword/g' database.properties
    rm -f database.properties.bak
else
    echo "Khong tim thay file database.properties!"
fi

echo "[2/3] Dang bien dich ma nguon..."
mvn clean package -DskipTests

echo "[3/3] Dang build va khoi dong cac container Docker..."
docker compose up -d --build

echo "[HOAN TAT!]"
echo "Ban co the xem log cua server bang lenh: docker compose logs -f server"
echo "======================================"
