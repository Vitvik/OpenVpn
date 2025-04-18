#!/bin/bash
# OpenVPN Access Server Installation Script
sudo apt update && sudo apt upgrade -y
sudo timedatectl set-timezone Europe/Berlin
sudo wget https://packages.openvpn.net/as/install.sh
sudo chmod +x install.sh
sudo bash install.sh --yes

until systemctl is-active --quiet openvpnas; do
    echo "Waiting for openvpnas service to start..."
    sleep 2
done
