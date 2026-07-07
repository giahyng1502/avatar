#!/bin/bash
echo "======================================"
echo "    KICH HOAT CAP NHAT CODE LEN VPS   "
echo "======================================"

echo "[1/3] Dang day code len GitHub..."
git add .
git commit -m "Update server code"
git push

echo "[2/3] Ket noi vao VPS va bat dau cap nhat..."
ssh -o StrictHostKeyChecking=no -i /Users/giahyng/Downloads/ninja.pem ubuntu@ec2-54-255-161-217.ap-southeast-1.compute.amazonaws.com << 'EOF'
  if [ ! -d "/home/ubuntu/avatar" ]; then
    git clone https://github.com/giahyng1502/avatar.git /home/ubuntu/avatar
  fi
  cd /home/ubuntu/avatar
  git reset --hard
  git pull origin main
  chmod +x run.sh
  ./run.sh
EOF

echo "[3/3] TRIEN KHAI HOAN TAT!"
echo "Server cua ban da duoc cap nhat va khoi dong lai tren VPS."
echo "======================================"
