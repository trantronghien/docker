#!/bin/bash

# Địa chỉ IP của các nodes
MANAGER1_IP="192.168.56.11"
MANAGER_IPS=("192.168.56.12" "192.168.56.13")
WORKER_IPS=("192.168.56.21" "192.168.56.22" "192.168.56.23" "192.168.56.24" "192.168.56.25")

# Thông tin username và password
USER="vagrant"  # Username mặc định trong Vagrant
PASSWORD="vagrant"  # Password của Vagrant (nếu thay đổi thì cập nhật)

# Khởi tạo Swarm trên manager1
echo "Khởi tạo Swarm trên manager1 ($MANAGER1_IP)..."
docker swarm init --advertise-addr $MANAGER1_IP

# Lấy token cho worker và manager
WORKER_TOKEN=$(docker swarm join-token -q worker)
MANAGER_TOKEN=$(docker swarm join-token -q manager)

# Sửa cấu hình Docker (daemon.json) để tắt live-restore trên các máy ảo
echo "Chỉnh sửa cấu hình Docker để tắt live-restore..."
for NODE_IP in "${MANAGER_IPS[@]}" "${WORKER_IPS[@]}"; do
  # Lệnh để sửa /etc/docker/daemon.json
  COMMAND="sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$NODE_IP 'echo \"{\\\"live-restore\\\": false}\" | sudo tee /etc/docker/daemon.json'"
  echo "Executing: $COMMAND"
  eval $COMMAND

  # Khởi động lại Docker để áp dụng thay đổi
  COMMAND="sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$NODE_IP 'sudo systemctl restart docker'"
  echo "Restarting Docker on $NODE_IP..."
  eval $COMMAND
done

# Thêm các manager nodes khác vào Swarm
echo "Thêm các manager nodes khác vào Swarm..."
for MANAGER_IP in "${MANAGER_IPS[@]}"; do
  COMMAND="sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$MANAGER_IP \"docker swarm join --token $MANAGER_TOKEN $MANAGER1_IP:2377\""
  echo "Executing: $COMMAND"
  eval $COMMAND
done

# Thêm các worker nodes vào Swarm
echo "Thêm các worker nodes vào Swarm..."
for WORKER_IP in "${WORKER_IPS[@]}"; do
  sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER_IP "docker swarm join --token $WORKER_TOKEN $MANAGER1_IP:2377"
done

# Chạy Portainer trên manager1
echo "Chạy Portainer trên manager1 ($MANAGER1_IP)..."
docker service create \
  --name portainer \
  --publish 9000:9000 \
  --replicas=1 \
  --constraint 'node.role == manager' \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  portainer/portainer-ce

echo "Swarm cluster đã được cấu hình thành công!"
