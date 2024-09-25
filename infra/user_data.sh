#! /bin/bash
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--tls-san your_server_ip" sh -
sudo apt update -y && sudo apt install docker.io -y
sudo usermod -aG docker $USER
newgrp docker