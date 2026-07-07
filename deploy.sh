#!/bin/bash
echo "======================================"
echo "    KICH HOAT CAP NHAT CODE LEN VPS   "
echo "======================================"

echo "[1/3] Dang dong bo code truc tiep len VPS..."
rsync -avz --exclude '.git' --exclude 'target' -e "ssh -o StrictHostKeyChecking=no -i /Users/giahyng/Downloads/ninja.pem" /Users/giahyng/Downloads/Avatar-Sv-master-master/ ubuntu@ec2-54-255-161-217.ap-southeast-1.compute.amazonaws.com:/home/ubuntu/avatar/

echo "[2/3] Ket noi vao VPS va bat dau cap nhat..."
ssh -o StrictHostKeyChecking=no -i /Users/giahyng/Downloads/ninja.pem ubuntu@ec2-54-255-161-217.ap-southeast-1.compute.amazonaws.com << 'EOF'
  cd /home/ubuntu/avatar
  chmod +x run.sh
  ./run.sh
EOF

echo "[3/3] TRIEN KHAI HOAN TAT!"
echo "Server cua ban da duoc cap nhat va khoi dong lai tren VPS."
echo "======================================"
