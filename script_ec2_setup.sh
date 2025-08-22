#!/usr/bin/env bash
set -euo pipefail

echo "[1/5] Atualizando pacotes..."
sudo apt-get update -y

echo "[2/5] Instalando Docker e plugins..."
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER || true

echo "[3/5] Habilitando Docker na inicialização..."
sudo systemctl enable docker
sudo systemctl start docker

echo "[4/5] Instalando docker-compose plugin e git..."
sudo apt-get install -y docker-compose-plugin git

echo "[5/5] Criando diretório do app..."
mkdir -p ~/app

echo "-------------------------------------------------"
echo "Setup concluído. Faça logout e login novamente ou rode:"
echo "  newgrp docker"
echo "Depois: coloque o projeto em ~/app e rode"
echo "  docker compose up -d --build"
